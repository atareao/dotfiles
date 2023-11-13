import Applauncher from "./applauncher/Applauncher.js";
import PowerMenu from "./powermenu/PowerMenu.js";
import Verification from "./powermenu/Verification.js";
import options from "./options.js";
import { init } from "./settings/setup.js";

init();

const windows = () => [
    Applauncher(),
    PowerMenu(),
    Verification(),
];

export default {
  windows: windows().flat(1),
  maxStreamVolume: 1.05,
  cacheNotificationActions: true,
  closeWindowDelay: {
    quicksettings: options.transition.value,
    dashboard: options.transition.value,
  },
};
