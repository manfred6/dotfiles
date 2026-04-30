import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io

Item {

    implicitWidth: colRam.implicitWidth
    implicitHeight: colRam.implicitHeight

    property int ramUsage: 0
    property real ramUsedGB: 0
    property real ramTotalGB: 0

    Process {
        id: ramProc
        command: ["sh", "-c", "free --giga"]

        // thanks tony 
        stdout: SplitParser {
            onRead: data => {
                if (!data.startsWith("Mem:")) return

                var p = data.trim().split(/\s+/)
                var total = parseInt(p[1])
                var used = parseInt(p[2])

                ramTotalGB = total
                ramUsedGB = used
                ramUsage   = Math.round(100 * (used / total))
            }
        }

        Component.onCompleted: running = true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: ramProc.running = true
    }

    Column {
        id: colRam
        spacing: 0
        Text {
            id: ramIcon
            anchors.horizontalCenter: parent.horizontalCenter
            text: "\ue322"  // memory
            color: Theme.colRam
            font.family: Theme.iconFont
            font.pixelSize: Theme.fontSize + 2
        }
        
        Text {
            id: ramText
            anchors.horizontalCenter: parent.horizontalCenter
            text: ramUsage + "%"
            color: Theme.colRam
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize - Theme.fontSize * 0.25
                bold: false
            }
        }
    }
}
