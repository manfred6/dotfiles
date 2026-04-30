import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: root
    implicitWidth: colLayout.implicitWidth
    implicitHeight: colLayout.implicitHeight
    
    property string currentLayoutName: ""
    
    readonly property var layoutEmoji: ({
        "English (US)": "🇺🇸",
        "German": "🇩🇪"
    })
    
    readonly property string displayText: {
        if (!currentLayoutName) return "??"
        return layoutEmoji[currentLayoutName] || currentLayoutName.substring(0, 2).toUpperCase()
    }
    
    function parseLayouts(text) {
        var lines = text.split("\n")
        for (var i = 0; i < lines.length; i++) {
            var line = lines[i].trim()
            if (line.startsWith("*")) {
                var match = line.match(/^\*\s+\d+\s+(.+)$/)
                if (match) {
                    root.currentLayoutName = match[1]
                    return
                }
            }
        }
    }
    
    // Initial query on startup
    Process {
        id: queryProc
        command: ["niri", "msg", "keyboard-layouts"]
        stdout: StdioCollector {
            onStreamFinished: root.parseLayouts(text)
        }
        Component.onCompleted: running = true
    }
    
    // Switch layout, then re-read
    Process {
        id: switchProc
        command: ["sh", "-c", "niri msg action switch-layout next && niri msg keyboard-layouts"]
        stdout: StdioCollector {
            onStreamFinished: root.parseLayouts(text)
        }
    }
    
    Process {
        id: switchPrevProc
        command: ["sh", "-c", "niri msg action switch-layout prev && niri msg keyboard-layouts"]
        stdout: StdioCollector {
            onStreamFinished: root.parseLayouts(text)
        }
    }
    
    // Periodic refresh in case layout was changed via keyboard shortcut
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: queryProc.running = true
    }
    
    Column {
        id: colLayout
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0
        
        MouseArea {
            id: clickArea
            implicitWidth: keyLayoutIcon.implicitWidth
            implicitHeight: keyLayoutIcon.implicitHeight
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            
            onClicked: (mouse) => {
                if (mouse.button === Qt.RightButton) {
                    switchPrevProc.running = true
                } else {
                    switchProc.running = true
                }
            }
            
            Text {
                id: keyLayoutIcon
                text: root.displayText
                color: Theme.colText
                font.family: "Noto Color Emoji"
                font.pixelSize: Theme.fontSize * 0.9
                anchors.centerIn: parent
            }
        }
    }
}
