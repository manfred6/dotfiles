import Quickshell
import QtQuick

Item {

    implicitWidth: powerIcon.implicitWidth
    implicitHeight: powerIcon.implicitHeight

    Text {
        id: powerIcon 
        anchors.horizontalCenter: parent.horizontalCenter
        text: "\ue8ac"  // power_settings_new
        color: Theme.colPower
        font.family: Theme.iconFont
        font.pixelSize: Theme.fontSize
    }
}
