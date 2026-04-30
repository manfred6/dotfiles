import QtQuick
import Quickshell
import Quickshell.Bluetooth

Item {

    implicitWidth: colBluetooth.implicitWidth
    implicitHeight: colBluetooth.implicitHeight

    Column {
        id: colBluetooth
        spacing: 0
        visible: Bluetooth.defaultAdapter !== null
        readonly property bool poweredOn: Bluetooth.defaultAdapter?.enabled ?? false
        readonly property bool hasConnectedDevice: {
            if (!Bluetooth.defaultAdapter) return false
            var devs = Bluetooth.defaultAdapter.devices.values
            for (var i = 0; i < devs.length; i++) {
                if (devs[i].connected) return true
            }
            return false
        }   
        Text {
            text: {
                if (!parent.poweredOn) return "\ue1a9"           // bluetooth_off
                if (parent.hasConnectedDevice) return "\ue1a8"   // bluetooth_connect
                return "\ue1a7"                                  // bluetooth (just on)
            }
            color: parent.poweredOn ? Theme.colText : Qt.darker(Theme.colText, 1.5)
            font.family: Theme.iconFont
            font.pixelSize: Theme.fontSize
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

