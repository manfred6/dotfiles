import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import Quickshell.Services.SystemTray

// https://github.com/caelestia-dots/shell/blob/main/components/effects/InnerBorder.qml

Scope {

    // Four invisible strut-only panels for Niri allignment
    PanelWindow {
        anchors { top: true; left: true; bottom: true }
        width: Theme.leftWidth
        exclusiveZone: Theme.leftWidth
        color: "transparent"
        // no content — just reserves space
    }
    PanelWindow {
        anchors { top: true; right: true; bottom: true }
        width: Theme.rightWidth
        exclusiveZone: Theme.rightWidth
        color: "transparent"
    }
    PanelWindow {
        anchors { top: true; left: true; right: true }
        height: Theme.topHeight
        exclusiveZone: Theme.topHeight
        color: "transparent"
    }
    PanelWindow {
        anchors { bottom: true; left: true; right: true }
        height: Theme.botHeight
        exclusiveZone: Theme.botHeight
        color: "transparent"
    }

    PanelWindow {
        id: root
        anchors.top: true
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        color: "transparent"

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        mask: Region {
            item: root
            intersection: Intersection.Xor
            Region { item: inner }
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.colBar

            layer.enabled: true
            layer.effect: MultiEffect {
                maskSource: maskItem
                maskEnabled: true
                maskInverted: true
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1
            }
            
            Item {
                id: leftBar
                x: 0
                y: 0
                width: Theme.leftWidth
                height: parent.height

                // BOT SECTION
                Rectangle {
                    id: botPowerMenu
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: Theme.botHeight
                    width: parent.width - 15
                    height: 50
                    radius: width / 2
                    color: "#2a2a2a"

                    Power {
                        id: power
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: botDateBackground
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: botPowerMenu.top//parent.bottom
                    anchors.bottomMargin: Theme.botHeight
                    width: parent.width - 15
                    height: dateTime.height + 20
                    radius: width / 2
                    color: Theme.nestedBackgroundElmnt 

                    DateTime {
                        id: dateTime
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                }

                Rectangle {
                    id: botPillBackground
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: botDateBackground.top//parent.bottom
                    anchors.bottomMargin: Theme.botHeight
                    width: parent.width - 15
                    height: tray.height + 20
                    radius: width / 2
                    color: Theme.nestedBackgroundElmnt 

                    Tray { 
                        id: tray
                        anchors.bottom: parent.bottom 
                        anchors.bottomMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                // MID SECTION
                //
                //

                // TOP SECTION
                Rectangle {
                    id: topSysStats
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: topGraphic.bottom
                    anchors.topMargin: Theme.topHeight
                    width: parent.width - 15
                    height: 50
                    radius: 100
                    color: "#2a2a2a"

                    Cpu { 
                        id: cpu 
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: topGraphic
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: Theme.topHeight
                    width: parent.width - 15
                    height: graphic.height + 20
                    radius: graphic.width 
                    color: "#2a2a2a"

                    Graphic { 
                        id: graphic 
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                
            }

            Item {
                id: rightBar
                x: parent.width - Theme.rightWidth
                y: 0
                width: Theme.rightWidth
                height: parent.height
            }

            Item {
                id: topBar
                x: 0
                y: 0
                width: parent.width
                height: Theme.topHeight
            }

            Item {
                id: bottomBar
                x: 0
                y: parent.height - Theme.botHeight
                width: parent.width
                
                height: Theme.botHeight
            }
            
        }

        Item {
            id: maskItem
            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                id: inner
                anchors.fill: parent
                anchors.topMargin: Theme.topHeight
                anchors.bottomMargin: Theme.botHeight
                anchors.rightMargin: Theme.rightWidth
                anchors.leftMargin: Theme.leftWidth
                radius: Theme.barRadius
            }
        }
    }
}
