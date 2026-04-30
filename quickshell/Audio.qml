import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Services.Pipewire

Item {
    id: root
    implicitWidth: colAudio.implicitWidth
    implicitHeight: colAudio.implicitHeight
    
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: sink?.audio?.muted ?? false
    
    MouseArea {
        id: clickArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        
        onClicked: (mouse) => {
            if (mouse.button === Qt.LeftButton) {
                volumePopup.visible = !volumePopup.visible
            } else if (mouse.button === Qt.RightButton) {
                if (root.sink?.audio) root.sink.audio.muted = !root.sink.audio.muted
            }
        }
        
        onWheel: (wheel) => {
            if (!root.sink?.audio) return
            var delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
            root.sink.audio.volume = Math.max(0, Math.min(1, root.sink.audio.volume + delta))
            wheel.accepted = true
        }
        
        Column {
            id: colAudio
            spacing: 0
            
            Text {
                text: {
                    if (root.muted || root.volume === 0) return "\ue04f"
                    if (root.volume < 0.33) return "\ue04d"
                    if (root.volume < 0.66) return "\ue050"
                    return "\ue1b8"
                }
                color: Theme.colText
                font.family: Theme.iconFont
                font.pixelSize: Theme.fontSize
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            //Text {
            //    text: Math.round(root.volume * 100) + "%"
            //    color: Theme.colText
            //    font.family: Theme.fontFamily
            //    font.pixelSize: Theme.fontSize * 0.9
            //    anchors.horizontalCenter: parent.horizontalCenter
            //}
        }
    }
}
