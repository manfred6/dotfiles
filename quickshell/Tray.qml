// Tray.qml

import QtQuick
import Quickshell.Services.SystemTray

Item {

    implicitWidth: colTray.implicitWidth
    implicitHeight: colTray.implicitHeight

    Column {
        id: colTray

        anchors.centerIn: parent
        spacing: 4
    
        Repeater {
            model: SystemTray.items
            
            MouseArea {
                required property SystemTrayItem modelData
    
                width: Theme.fontSize
                height: Theme.fontSize
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                clip: false
    
                onClicked: event => {
                    if (event.button === Qt.LeftButton)
                        modelData.activate();
                    else
                        modelData.secondaryActivate();
                }

                Image {
                    anchors.fill: parent
                    sourceSize.width: Theme.fontSize
                    sourceSize.height: Theme.fontSize
                    source: {
                        let icon = modelData.icon;
                        if (icon.includes("?path=")) {
                            const [name, path] = icon.split("?path=");
                            return Qt.resolvedUrl(`${path}/${name.slice(name.lastIndexOf("/") + 1)}`);
                        }
                        return icon;
                    }
                }
            }
        }
    }
}

