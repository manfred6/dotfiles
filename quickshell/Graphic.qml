import Quickshell
import QtQuick

Item {

    implicitHeight: graphicIcon.height
    implicitWidth: graphicIcon.width

    Text {
        id: graphicIcon
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.top: parent.top
        //anchors.topMargin: 8
        text: "\ueef8"
        color: Theme.colIcon
        font.family: Theme.fontFamily // nerd fonts for this one
        font.pixelSize: Theme.fontSize
    }
}
