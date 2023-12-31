import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Sway from "../../services/sway.js";
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import PanelButton from '../PanelButton.js';
import options from '../../options.js';
import { substitute } from '../../utils.js';

export const ClientLabel = () => Widget.Label({
    binds: [['label', Sway.active.client, 'class', c => {
        const { titles } = options.substitutions;
        return substitute(titles, c);
    }]],
});

export const ClientIcon = () => Widget.Icon({
    connections: [[Sway.active.client, self => {
        const { icons } = options.substitutions;
        const { client } = Sway.active;

        const classIcon = substitute(icons, client.class) + '-symbolic';
        const titleIcon = substitute(icons, client.class) + '-symbolic';

        const hasTitleIcon = Utils.lookUpIcon(titleIcon);
        const hasClassIcon = Utils.lookUpIcon(classIcon);

        if (hasClassIcon)
            self.icon = classIcon;

        if (hasTitleIcon)
            self.icon = titleIcon;

        self.visible = !!(hasTitleIcon || hasClassIcon);
    }]],
});

export default () => PanelButton({
    class_name: 'focused-client',
    content: Widget.Box({
        children: [
            ClientIcon(),
            ClientLabel(),
        ],
        binds: [['tooltip-text', Sway.active, 'client', c => c.title]],
    }),
});
