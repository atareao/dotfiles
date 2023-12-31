import GLib from "gi://GLib";
import Gio from "gi://Gio";
import Service from "resource:///com/github/Aylur/ags/service.js";
import { struct, concatArrayBuffers } from "../utils.js";

Gio._promisify(Gio.DataInputStream.prototype, "read_upto_async");
Gio._promisify(Gio.DataInputStream.prototype, "read_bytes_async");

const EventType = {
  WORKSPACE: 0,
  OUTPUT: 1,
  MODE: 2,
  WINDOW: 3,
  BARCONFIG_UPDATE: 4,
  BINDING: 5,
  SHUTDOWN: 6,
  TICK: 7,
  INPUT: 21,
};

class Active extends Service {
  updateProperty(prop, value) {
    super.updateProperty(prop, value);
    this.emit("changed");
  }
}

class ActiveClient extends Active {
  static {
    Service.register(
      this,
      {},
      {
        address: ["string"],
        title: ["string"],
        class: ["string"],
      },
    );
  }

  #address = "";
  #title = "";
  #class = "";

  get address() {
    return this.#address;
  }
  get title() {
    return this.#title;
  }
  get class() {
    return this.#class;
  }
}

export class ActiveWorkspace extends Active {
  static {
    Service.register(
      this,
      {},
      {
        id: ["int"],
        name: ["string"],
      },
    );
  }

  #id = 1;
  #name = "";

  get id() {
    return this.#id;
  }
  get name() {
    return this.#name;
  }
}

export class Actives extends Service {
  static {
    Service.register(
      this,
      {},
      {
        client: ["jsobject"],
        monitor: ["string"],
        workspace: ["jsobject"],
      },
    );
  }

  #client = new ActiveClient();
  #monitor = "";
  #workspace = new ActiveWorkspace();

  constructor() {
    super();

    [this.#client, this.#workspace].forEach((s) =>
      s.connect("changed", () => this.emit("changed")),
    );

    ["id", "name"].forEach((attr) =>
      this.#workspace.connect(`notify::${attr}`, () =>
        this.changed("workspace"),
      ),
    );

    ["address", "title", "class"].forEach((attr) =>
      this.#client.connect(`notify::${attr}`, () => this.changed("client")),
    );
  }

  get client() {
    return this.#client;
  }
  get monitor() {
    return this.#monitor;
  }
  get workspace() {
    return this.#workspace;
  }
}

class Sway extends Service {
  static {
    Service.register(
      this,
      {
        "urgent-window": ["string"],
        submap: ["string"],
        "keyboard-layout": ["string", "string"],
        "monitor-added": ["string"],
        "monitor-removed": ["string"],
        "client-added": ["string"],
        "client-removed": ["string"],
        "workspace-added": ["string"],
        "workspace-removed": ["string"],
        "workspace-changed": ["int"],
        fullscreen: ["boolean"],
      },
      {
        active: ["jsobject"],
        monitors: ["jsobject"],
        workspaces: ["jsobject"],
        clients: ["jsobject"],
      },
    );
  }

  static #SWAYSOCK = GLib.getenv("SWAYSOCK");
  static #MAGIC = "i3-ipc";
  static #STRUCT_HEADER = "<6sII";
  static #STRUCT_HEADER_LENGTH = 14;
  static #MsgType = {
    RUN_COMMAND: 0,
    GET_WORKSPACES: 1,
    SUBSCRIBE: 2,
    GET_OUTPUTS: 3,
    GET_TREE: 4,
    GET_MARKS: 5,
    GET_BAR_CONFIG: 6,
    GET_VERSION: 7,
    GET_BINDING_MODES: 8,
    GET_CONFIG: 9,
    SEND_TICK: 10,
    SYNC: 11,
    GET_BINDING_STATE: 12,
    GET_INPUTS: 100,
    GET_SEATS: 101,
  };

  get active() {
    return this._active;
  }
  get monitors() {
    return Array.from(this._monitors.values());
  }
  get workspaces() {
    return Array.from(this._workspaces.values());
  }
  get clients() {
    return Array.from(this._clients.values());
  }

  getMonitor(id) {
    return this._monitors.get(id);
  }
  getWorkspace(id) {
    return this._workspaces.get(id);
  }
  getClient(address) {
    return this._clients.get(address);
  }

  constructor() {
    super();
    if (!Sway.#SWAYSOCK) {
     console.error("Sway is not running");
    }
    this.socketAddress = new Gio.UnixSocketAddress({ path: Sway.#SWAYSOCK });
    console.debug(this.socketAddress);
    this._focusedWorkspace = null;
    this._active = new Actives();
    this._monitors = new Map();
    this._workspaces = new Map();
    this._clients = new Map();
    this._decoder = new TextDecoder();
    this._encoder = new TextEncoder();
    this._syncMonitors();
    this._syncWorkspaces();
    const clients = this.getClients();
    print("===============================");
    print(JSON.stringify(clients));
    print("===============================");
    //this._syncClients();

    this._subCon = new Gio.SocketClient().connect(
      new Gio.UnixSocketAddress({ path: Sway.#SWAYSOCK }),
      null,
    );
    this._subIS = this._subCon.get_input_stream();
    this._subOS = this._subCon.get_output_stream();

    this._subscribe();
    this._watchSocket();

    this._active.connect("changed", () => this.emit("changed"));
    ["monitor", "workspace", "client"].forEach((active) =>
      this._active.connect(`notify::${active}`, () => this.changed("active")),
    );
  }

  getFocusedWorkspace(){
    return this._focusedWorkspace;
  }

  _syncMonitors() {
    try {
      const monitors = this.getOutputs();
      this._monitors = new Map();
      monitors.forEach((monitor) => {
        this._monitors.set(monitor.id, monitor);
      });
      this.notify("monitors");
    } catch (error) {
      if (error instanceof Error) {
        console.error(error.message);
      }
    }
  }
  _syncWorkspaces() {
    try {
      const workspaces = this.getWorkspaces();
      this._workspaces = new Map();
      workspaces.forEach((ws) => {
        this._workspaces.set(ws.num, ws);
        if (ws.focused) {
          this._focusedWorkspace = ws;
          this._active.updateProperty("monitor", ws.output);
          this._active.workspace.updateProperty("id", ws.num);
          this._active.workspace.updateProperty("name", ws.name);
          console.log(`active workspace: ${ws.num}`);
        }
      });
      this.notify("workspaces");
    } catch (error) {
      if (error instanceof Error) {
        console.error(error.message);
      }
    }
  }

  _subscribe() {
    console.debug("_subscribe");
    try {
      const msg_type = Sway.#MsgType.SUBSCRIBE;
      const payload = '["workspace", "window"]';
      this._subOS.write_bytes(Sway.#pack(msg_type, payload), null);
      const response = this.recvFromSubscription();
      console.debug(
        `Message type: ${msg_type}. Payload: ${payload}. Response: ${response}`,
      );
      return response;
    } catch (err) {
      console.error(err);
    }
  }

  async _watchSocket() {
    console.debug("_watchSocket");

    this._subIS.read_bytes_async(
      Sway.#STRUCT_HEADER_LENGTH,
      1,
      null,
      async (subis, data) => {
          const glib_data = subis.read_bytes_finish(data);
          let content = glib_data.get_data();
          const [msg_magic, msg_length, msg_type] = Sway.#unpack_header(content);
          const event_type = msg_type & 0x7f;
          console.debug(event_type);

          const msg_size = Sway.#STRUCT_HEADER_LENGTH + msg_length;
          while (content.length < msg_size) {
            const new_input = subis.read_bytes(msg_length, null).get_data();
            const new_data = new Uint8Array(content.length + new_input.length);
            new_data.set(content, 0);
            new_data.set(new_input, content.length);
            content = new_data;
          }
          const response = Sway.#unpack(content);
          const event = JSON.parse(response);
          this._onEvent(event_type, event);
          await this._watchSocket();
      },
    );
  }

  setWorkspace(number) {
    const msg_type = Sway.#MsgType.RUN_COMMAND;
    const payload = `workspace number ${number}`;
    const response = this.sendMessage(msg_type, payload);
    console.debug(response);
  }

  setNextWorkspace(){
    const number = this._active.workspace.id + 1;
    this.setWorkspace((number > 10)?1:number);
  }

  setPreviousWorkspace(){
    const number = this._active.workspace.id - 1;
    this.setWorkspace((number < 1)?1:number);
  }

  sendMessage(msg_type, payload) {
    return Sway.#send(msg_type, payload);
  }

  static #send(msg_type, payload = "") {
    let connection = null;
    try {
      const socketAddress = new Gio.UnixSocketAddress({ path: Sway.#SWAYSOCK });
      let client = new Gio.SocketClient();
      connection = client.connect(socketAddress, null);
      if (!connection) {
        throw "Connection failed";
      }
      let output = connection.get_output_stream();
      output.write_bytes(Sway.#pack(msg_type, payload), null);
      const response = Sway.#recv(connection);
      console.debug(
        `Message type: ${msg_type}. Payload: ${payload}. Response: ${response}`,
      );
      return response;
    } catch (err) {
      console.error(err);
      return false;
    } finally {
      if (connection != null) {
        connection.close(null);
      }
    }
  }

  static #recv(connection) {
    console.debug(`recv: ${connection}`);
    const input = connection.get_input_stream();
    let data = input.read_bytes(this.#STRUCT_HEADER_LENGTH, null).get_data();
    const [msg_magic, msg_length, msg_type] = this.#unpack_header(data);
    const msg_size = this.#STRUCT_HEADER_LENGTH + msg_length;
    console.debug(data.length);
    while (data.length < msg_size) {
      const new_input = input.read_bytes(msg_length, null).get_data();
      const new_data = new Uint8Array(data.length + new_input.length);
      new_data.set(data, 0);
      new_data.set(new_input, data.length);
      data = new_data;
    }
    const response = Sway.#unpack(data);
    return JSON.parse(response);
  }
  recvFromSubscription() {
    console.debug("recvFromSubscription");
    let data = this._subIS
      .read_bytes(Sway.#STRUCT_HEADER_LENGTH, null)
      .get_data();
    const [msg_magic, msg_length, msg_type] = Sway.#unpack_header(data);
    const msg_size = Sway.#STRUCT_HEADER_LENGTH + msg_length;
    console.debug(data.length);
    while (data.length < msg_size) {
      const new_input = this._subIS.read_bytes(msg_length, null).get_data();
      const new_data = new Uint8Array(data.length + new_input.length);
      new_data.set(data, 0);
      new_data.set(new_input, data.length);
      data = new_data;
    }
    const response = Sway.#unpack(data);
    console.debug(response);
    return JSON.parse(response);
  }

  getOutputs() {
    console.debug("getOutputs");
    return this.sendMessage(Sway.#MsgType.GET_OUTPUTS);
  }

  getWorkspaces() {
    console.debug("getWorkspaces");
    return this.sendMessage(Sway.#MsgType.GET_WORKSPACES);
  }

  getTree() {
    console.debug("getTree");
    return this.sendMessage(Sway.#MsgType.GET_TREE);
  }

  getClients() {
    console.debug("getClients");
    const tree = this.sendMessage(Sway.#MsgType.GET_TREE);
    let clients = [];
    const root = {
      id: tree["id"],
      name: tree["name"],
      rect: tree["rect"]
    };
    tree["nodes"].forEach((node) => {
      //outputs
      if("make" in node && "model" in node && "serial" in node){
        const output = {
          id: node["id"],
          name: node["name"],
          rect: node["rect"],
          make: node["make"],
          model: node["model"],
          serial: node["serial"],
          root: root
        }
        //workspaces
        node["nodes"].forEach((node) => {
          if("num" in node){
            const workspace = {
              id: node["id"],
              name: node["name"],
              rect: node["rect"],
              num: node["num"],
              output: output
            }
            //clients
            const some_clients = this._getClients(node["nodes"], workspace);
            some_clients.forEach((client) => clients.push(client));
          }
        })
      }
    });
    return clients;
  }

  _getClients(nodes, workspace){
    let clients = [];
    nodes.forEach((node) => {
      if("app_id" in node){
        const client = {
            id: node["id"],
            name: node["name"],
            rect: node["rect"],
            focused: node["focused"],
            pid: node["pid"],
            app_id: node["app_id"],
            workspace: workspace
        }
        clients.push(client);
      }else if("nodes" in node){
        const more_clients = this._getClients(node["nodes"], workspace);
        more_clients.forEach((client) => clients.push(client));
      }
    });
    return clients;
  }

  static #pack(msg_type, payload) {
    console.debug(`pack: ${msg_type} - ${payload}`);
    const m = new TextEncoder().encode(Sway.#MAGIC);
    const pb = new TextEncoder().encode(payload);
    const s = new Uint8Array(struct("<II").pack(pb.length, msg_type));
    return concatArrayBuffers(m, s, pb);
  }

  static #unpack_header(data) {
    console.debug("unpack_header");
    const slice = data.slice(0, Sway.#STRUCT_HEADER_LENGTH);
    return struct(Sway.#STRUCT_HEADER).unpack(slice.buffer);
  }
  static #unpack(data) {
    console.debug("unpack");
    const [msg_magic, msg_length, msg_type] = Sway.#unpack_header(data);
    const msg_size = Sway.#STRUCT_HEADER_LENGTH + msg_length;
    const payload = data.slice(Sway.#STRUCT_HEADER_LENGTH, msg_size);
    return new TextDecoder().decode(payload);
  }

  _onEvent(event_type, event) {
    const event_str = (event != null)?JSON.stringify(event):null;
    console.log(`_onEvent. event_type: ${event_type}, event: ${event_str}`);
    if (event_type == null || event == null) {
      return;
    }
    // event_type:
    // 0 => workspace
    // 3 => window
    console.log(`_onEvent. event_type: ${event_type}, event.change: ${event.change}`);
    if(event_type == 0 && event.change == "focus"){
      const event_str = JSON.stringify(event);
      console.log(`event_type: ${event_type}, event: ${event_str}`);
      this._syncWorkspaces();
      this.emit("workspace-changed", this._active.workspace.id);
      console.log("workspace-changed");
    }
  }

  async _onEvent2(event) {
    if (!event) return;

    const [e, params] = event.split(">>");
    const argv = params.split(",");

    try {
      switch (e) {
        case "workspace":
        case "focusedmon":
          await this._syncMonitors();
          break;

        case "monitorremoved":
          await this._syncMonitors();
          this.emit("monitor-removed", argv[0]);
          break;

        case "monitoradded":
          await this._syncMonitors();
          this.emit("monitor-added", argv[0]);
          break;

        case "createworkspace":
          await this._syncWorkspaces();
          this.emit("workspace-added", argv[0]);
          break;

        case "destroyworkspace":
          await this._syncWorkspaces();
          this.emit("workspace-removed", argv[0]);
          break;

        case "openwindow":
          await this._syncClients();
          await this._syncWorkspaces();
          this.emit("client-added", "0x" + argv[0]);
          break;

        case "movewindow":
        case "windowtitle":
          await this._syncClients();
          await this._syncWorkspaces();
          break;

        case "moveworkspace":
          await this._syncWorkspaces();
          await this._syncMonitors();
          break;

        case "fullscreen":
          await this._syncClients();
          await this._syncWorkspaces();
          this.emit("fullscreen", argv[0] === "1");
          break;

        case "activewindow":
          this._active.client.updateProperty("class", argv[0]);
          this._active.client.updateProperty("title", argv.slice(1).join(","));
          break;

        case "activewindowv2":
          this._active.client.updateProperty("address", "0x" + argv[0]);
          break;

        case "closewindow":
          this._active.client.updateProperty("class", "");
          this._active.client.updateProperty("title", "");
          this._active.client.updateProperty("address", "");
          await this._syncWorkspaces();
          this._clients.delete("0x" + argv[0]);
          this.emit("client-removed", "0x" + argv[0]);
          this.notify("clients");
          break;

        case "urgent":
          this.emit("urgent-window", "0x" + argv[0]);
          break;

        case "activelayout":
          this.emit("keyboard-layout", `${argv[0]}`, `${argv[1]}`);
          break;

        case "changefloatingmode": {
          const client = this._clients.get("0x" + argv[0]);
          if (client)
            // @ts-expect-error
            client.floating = argv[1] === "1";
          break;
        }
        case "submap":
          this.emit("submap", argv[0]);
          break;

        default:
          break;
      }
    } catch (error) {
      if (error instanceof Error) console.error(error.message);
    }

    this.emit("changed");
  }
}

export default new Sway();

