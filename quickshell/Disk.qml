import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io

Item {

    implicitWidth: colDisk.implicitWidth
    implicitHeight: colDisk.implicitHeight

    property string diskUsage: ""

    Process {
        id: diskProc
        command: ["sh", "-c", "df -h /"]

        stdout: SplitParser {
            onRead: data => {
                if (data.startsWith("Filesystem")) return
                var p = data.trim().split(/\s+/)
                diskUsage = p[4]
            }
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: diskProc.running = true
    }

    Column {
        id: colDisk
        spacing: 0
        Text {
            id: diskIcon
            anchors.horizontalCenter: parent.horizontalCenter
            text: "\uf3da"  // hard_disk
            color: Theme.colDisk
            font.family: Theme.iconFont
            font.pixelSize: Theme.fontSize + 2
        }
        
        Text {
            id: diskText
            anchors.horizontalCenter: parent.horizontalCenter
            text: diskUsage
            color: Theme.colDisk
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize - Theme.fontSize * 0.25
                bold: false
            }
        }
    }
}
