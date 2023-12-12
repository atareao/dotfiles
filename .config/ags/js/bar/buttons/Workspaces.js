import Widget from "resource:///com/github/Aylur/ags/widget.js";
//import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import * as Utils from "resource:///com/github/Aylur/ags/utils.js";
import options from "../../options.js";
import { range } from "../../utils.js";
import Sway from "../../services/sway.js";

/** @param {any} arg */
const dispatch2 = (arg) => {
    console.log(`swaymsg workspace number ${arg}`);
    Utils.execAsync(`swaymsg workspace number ${arg}`);
};
const dispatch = (arg) => {
    console.log(`swaymsg workspace number ${arg}`);
    Sway.setWorkspace(arg);
}

const Workspaces = () => {
  const ws = options.workspaces.value;
  return Widget.Box({
    children: range(ws || 20).map((i) =>
      Widget.Button({
        setup: (btn) => (btn.id = i),
        on_clicked: () => dispatch(i),
        child: Widget.Label({
          label: `${i}`,
          class_name: "indicator",
          vpack: "center",
        }),
        connections: [
          [
            Sway,
            (btn) => {
              btn.toggleClassName("active", Sway.active.workspace.id === i);
              btn.toggleClassName(
                "occupied",
                Sway.getWorkspace(i)?.windows > 0,
              );
            },
          ],
        ],
      }),
    ),
    connections: ws
      ? []
      : [
          [
            Sway.active.workspace,
            (box) =>
              box.children.map((btn) => {
                btn.visible = Sway.workspaces.some(
                  (ws) => ws.id === btn.id,
                );
              }),
          ],
        ],
  });
};

export default () =>
  Widget.Box({
    class_name: "workspaces panel-button",
    child: Widget.Box({
      // its nested like this to keep it consistent with other PanelButton widgets
      child: Widget.EventBox({
        on_scroll_up: () => dispatch("m+1"),
        on_scroll_down: () => dispatch("m-1"),
        class_name: "eventbox",
        binds: [["child", options.workspaces, "value", Workspaces]],
      }),
    }),
  });
