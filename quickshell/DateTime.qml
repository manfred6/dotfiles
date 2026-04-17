// DateTime.qml

import Quickshell
import QtQuick

// TODO: somehow minutes lag behind  by ~ 30s ...?

Item {

    implicitHeight: hours.implicitHeight + minutes.implicitHeight + calendarIcon.implicitHeight
    implicitWidth: hours.implicitWidth

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        id: calendarIcon 
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        text: "\uebcc"  // calendar_month
        color: Theme.colText
        font.family: Theme.iconFont
        font.pixelSize: 24
    }

    Text {
        id: hours
        anchors.top: calendarIcon.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatDateTime(clock.date, "hh")
        color: Theme.colText
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }

    Text {
        id: minutes
        anchors.top: hours.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatDateTime(clock.date, "mm")
        color: Theme.colText
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
    }
}
