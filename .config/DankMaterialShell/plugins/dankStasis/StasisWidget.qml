import QtQuick
import QtQuick.Controls
import qs.Widgets
import qs.Modules.Plugins
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Modules

PluginComponent {
    id: root

    // Propiedad para rastrear el estado
    property bool isInhibited: false
    property bool _initialLoad: true

    // 1. FUNCIÓN PARA ACTUALIZAR ESTADO
    function updateStatusFromText(output) {
        const cleanText = output.trim().toLowerCase();
        if (cleanText.includes("paused") || cleanText.includes("inhibited") || cleanText.includes("active")) {
            root.isInhibited = true;
        } else {
            root.isInhibited = false;
        }
    }

    onIsInhibitedChanged: {
        if (_initialLoad) {
            _initialLoad = false;
            return;
        }
        notifyProcess.running = true;
    }

    Process {
        id: notifyProcess
        command: ["notify-send", "-i", "dialog-information", "Stasis", root.isInhibited ? "Inhibido (Despierto)" : "Normal"]
    }

    // 2. PROCESO PARA CLIC (Toggle)
    Process {
        id: toggleInhibitProcess
        command: ["stasis", "toggle-inhibit"]
        stdout: StdioCollector {
            onStreamFinished: updateStatusFromText(text)
        }
    }

    // 3. PROCESO PARA ESTADO INICIAL
    Process {
        id: checkInitialStatus
        command: ["stasis", "status"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: updateStatusFromText(text)
        }
    }

    // 4. COMPONENTE DEL ICONO
    component StasisIcon: Item {
        id: icon

        property int size: Theme.barIconSize(root.barThickness, -4)
        property color iconColor: root.isInhibited ? "#FFA500" : (Theme.widgetIconColor || Theme.surfaceText)

        width: size
        height: size

        FontLoader {
            id: nerdFont
            source: "file:///usr/share/quickshell/dms/assets/fonts/nerd-fonts/FiraCodeNerdFont-Regular.ttf"
        }

        StyledText {
            anchors.centerIn: parent
            font.family: nerdFont.name
            font.pixelSize: icon.size
            color: icon.iconColor
            text: root.isInhibited ? "\u{F0176}" : "\u{F06CA}"
            antialiasing: true
        }

        MouseArea {
            id: clickArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onClicked: toggleInhibitProcess.running = true
        }

        ToolTip.visible: clickArea.containsMouse
        ToolTip.delay: 600
        ToolTip.text: root.isInhibited ? "Stasis: Inhibido (Despierto)" : "Stasis: Normal"
    }

    // Layouts de la barra
    horizontalBarPill: Row {
        spacing: Theme.spacingXS
        StasisIcon {
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    verticalBarPill: Column {
        spacing: Theme.spacingXS
        StasisIcon {
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
