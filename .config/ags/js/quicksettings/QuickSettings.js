import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Header from './widgets/Header.js';
import PopupWindow from '../misc/PopupWindow.js';
import { Volume, Microhone, SinkSelector, AppMixer } from './widgets/Volume.js';
import { NetworkToggle, WifiSelection } from './widgets/Network.js';
//import { BluetoothToggle, BluetoothDevices } from './widgets/Bluetooth.js';
import { ThemeToggle, ThemeSelector } from './widgets/Theme.js';
import { ProfileToggle, ProfileSelector } from './widgets/AsusProfile.js';
import Media from './widgets/Media.js';
import Brightness from './widgets/Brightness.js';
import DND from './widgets/DND.js';
import MicMute from './widgets/MicMute.js';

const Row = (toggles = [], menus = []) => Widget.Box({
    vertical: true,
    children: [
        Widget.Box({
            class_name: 'row horizontal',
            children: toggles,
        }),
        ...menus,
    ],
});

const Homogeneous = toggles => Widget.Box({
    homogeneous: true,
    children: toggles,
});

export default () => PopupWindow({
    name: 'quicksettings',
    anchor: ['top', 'right'],
    layout: 'top right',
    content: Widget.Box({
        vertical: true,
        children: [
            Header(),
            Widget.Box({
                class_name: 'sliders-box vertical',
                vertical: true,
                children: [
                    Row(
                        [Volume()],
                        [SinkSelector(), AppMixer()],
                    ),
                    Microhone(),
                    Brightness(),
                ],
            }),
            Row(
                [Homogeneous([
                  NetworkToggle(),
                  //BluetoothToggle()
                ]), DND()],
                [
                  WifiSelection(),
                  //BluetoothDevices()
                ],
            ),
            Row(
                [Homogeneous([ProfileToggle(), ThemeToggle()]), MicMute()],
                [ProfileSelector(), ThemeSelector()],
            ),
            Media(),
        ],
    }),
});
