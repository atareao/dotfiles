import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { Variable } from 'resource:///com/github/Aylur/ags/variable.js';
//import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import * as Utils from "resource:///com/github/Aylur/ags/utils.js";
import options from "../../options.js";
import { range } from "../../utils.js";
import Sway from "../../services/sway.js";

/** @param {any} arg */
const dispatch = (arg) => {
  Sway.setWorkspace(arg);
};

/** @type {Variable<string[]>} */
const number = new Variable([]);
const Workspaces = () => {
  const ws = options.workspaces.value;
  return Widget.Box({
    children: range(ws || 20).map((i) =>
      Widget.Button({
        setup: (btn) => (btn.id = i),
        on_clicked: () => dispatch(i),
        binds: [["tooltip-text", number, "value", () => `${i}`]],
        child: Widget.Label({
          label: `${i}`,
          class_name: "indicator",
          vpack: "center",
        }),
        connections: [
          [
            Sway,
            (self, num) => {
              console.log(num);
              const ws = Sway.getFocusedWorkspace();
              self.toggleClassName("active", ws.num === i);
              const thisws = Sway.getWorkspace(i);
              console.log(`ws => ${thisws}`);
              self.toggleClassName(
                "occupied",
                Sway.getWorkspace(i) != null,
              );
            },
            "workspace-changed"
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
                btn.visible = Sway.workspaces.some((ws) => ws.id === btn.id);
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
        on_scroll_up: () => Sway.setNextWorkspace(),
        on_scroll_down: () => Sway.setPreviousWorkspace(),
        class_name: "eventbox",
        binds: [["child", options.workspaces, "value", Workspaces]],
      }),
    }),
  });
