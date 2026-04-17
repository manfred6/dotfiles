import Quickshell
import QtQuick

Item {

    Text {
        id: powerIcon 
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.top: parent.top
        //anchors.topMargin: 8
        text: "\ue8ac"  // power_settings_new
        color: Theme.colText
        font.family: Theme.iconFont
        font.pixelSize: 24
    }
}
