import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { Variable } from 'resource:///com/github/Aylur/ags/variable.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import options from '../../options.js';
import { range } from '../../utils.js';
import Sway from "../../services/sway.js";

/** @param {any} arg */
const dispatch = (arg) => {
  Sway.setWorkspace(arg);
};

const number = new Variable([]);
const Workspaces = () => {
  const ws = options.workspaces.value;
  print("==========================");
  print(`workspaces: ${ws}`)
  print("==========================");
  return Widget.Box({
    children: range(ws || 20).map(i => Widget.Button({
      attribute: i,
      on_clicked: () => dispatch(i),
      tooltip_text: `${i}`,
      child: Widget.Label({
        label: `${i}`,
        class_name: 'indicator',
        vpack: 'center',
      }),
      setup: self => self.hook(Sway, () => {
        const isActive = Sway.active.workspace.id === i;
        const isOccupied = typeof Sway.getWorkspace(i) !== 'undefined';
        self.toggleClassName('active', isActive);
        self.toggleClassName('occupied', isOccupied);
      }),
    })),
    setup: box => {
      if (ws === 0) {
        box.hook(Sway.active.workspace, () => box.children.map(btn => {
          btn.visible = Sway.workspaces.some(ws => ws.id === btn.attribute);
        }));
      }
    },
  });
};

export default () => Widget.EventBox({
  class_name: 'workspaces panel-button',
  child: Widget.Box({
    // its nested like this to keep it consistent with other PanelButton widgets
    child: Widget.EventBox({
      on_scroll_up: () => Sway.setNextWorkspace(),
      on_scroll_down: () => Sway.setPreviousWorkspace(),
      class_name: 'eventbox',
      child: options.workspaces.bind("value").transform(Workspaces),
    }),
  }),
});
