import Quickshell
import QtQuick
import Quickshell.Services.UPower

Item {

    implicitWidth: colBattery.implicitWidth
    implicitHeight: colBattery.implicitHeight
    

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true
    }

    Column {
        id: colBattery
        spacing: 0
        visible: UPower.displayDevice.ready && UPower.displayDevice.isLaptopBattery
        
        // Pick an icon based on charge level and state
        readonly property string batteryIcon: {
            var pct = UPower.displayDevice.percentage * 100
            var charging = UPower.displayDevice.state === UPowerDeviceState.Charging
                        || UPower.displayDevice.state === UPowerDeviceState.FullyCharged
            
            if (charging) return "\uf250"          // battery_android_frame_bolt
            if (pct >= 90) return "\uf24f"         // battery_android_frame_full
            if (pct >= 70) return "\uf253"         // battery_android_frame_5
            if (pct >= 50) return "\uf254"         // battery_android_frame_4
            if (pct >= 30) return "\uf255"         // battery_android_frame_3
            if (pct >= 10) return "\uf256"         // battery_android_frame_2
            return "\uf306"                        // battery_android_alert
        }
        
        Text {
            id: batteryIcon
            text: parent.batteryIcon
            color: Theme.colText
            font.family: Theme.iconFont
            font.pixelSize: Theme.fontSize
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        //Text {
        //    text: Math.round(UPower.displayDevice.percentage * 100) + "%"
        //    color: Theme.colText
        //    font.family: Theme.fontFamily
        //    font.pixelSize: Theme.fontSize - Theme.fontSize * 0.25
        //    font.bold: false
        //    anchors.horizontalCenter: parent.horizontalCenter
        //}
    }
}

