import Quickshell
import QtQuick

// TODO: somehow minutes lag behind  by ~ 30s ...?

Item {

    implicitHeight: colClock.implicitHeight //hours.implicitHeight + minutes.implicitHeight + calendarIcon.implicitHeight
    implicitWidth: colClock.implicitWidth

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
    Column {
        id: colClock
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 0
 
        Text {
            id: calendarIcon 
            //anchors.top: parent.top
            //anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            text: "\uebcc"  // calendar_month
            color: Theme.colText
            font.family: Theme.iconFont
            font.pixelSize: Theme.fontSize
        }

        Text {
            id: hours
            //anchors.top: calendarIcon.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "hh")
            color: Theme.colText
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize * 0.80
        }

        Text {
            id: minutes
            //anchors.top: hours.bottom
            //anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "mm")
            color: Theme.colText
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize * 0.80
        }
    }
}
