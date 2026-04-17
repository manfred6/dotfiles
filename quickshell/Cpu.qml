import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io

// thanks tonybtw

Item {

    implicitWidth: colCpu.implicitWidth
    implicitHeight: colCpu.implicitHeight

    property int cpuUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        
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
        interval: 2000
        running: true
        repeat: true
        onTriggered: cpuProc.running = true
    }

    Text {
        id: cpuIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 8
        text: "\ue30d"  // developer_board
        color: Theme.colText
        font.family: Theme.iconFont
        font.pixelSize: Theme.fontSize
    }
    
    Text {

        id: colCpu
        anchors.centerIn: parent
        text: cpuUsage
        color: Theme.colText
        font {
            family: Theme.fontFamily
            pixelSize: Theme.fontSize
            bold: true
        }
    }
}
