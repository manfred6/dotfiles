import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io

Item {

    implicitWidth: colCpu.implicitWidth
    implicitHeight: colCpu.implicitHeight

    property int cpuUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]

        // thanks tony 
        stdout: SplitParser {
            onRead: data => {
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                if (lastCpuTotal > 0) {
                    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
                }
                lastCpuTotal = total
                lastCpuIdle = idle
            }
        }

        Component.onCompleted: running = true
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: cpuProc.running = true
    }

    Column {
        id: colCpu 
        spacing: 0
        Text {
            id: cpuIcon
            anchors.horizontalCenter: parent.horizontalCenter
            text: "\ue30d"  // developer_board
            color: Theme.colCpu
            font.family: Theme.iconFont
            font.pixelSize: Theme.fontSize
        }
        
        Text {
            id: cpuText
            anchors.horizontalCenter: parent.horizontalCenter
            text: cpuUsage + "%"
            color: Theme.colCpu
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize - Theme.fontSize * 0.25
                bold: false
            }
        }
    }
}
