import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import Quickshell.Services.SystemTray
import Quickshell.Widgets

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
                    height: powerGraphic.height + 10
                    radius: width / 2
                    color: Theme.colBar //Theme.nestedBackgroundElmnt

                    Power {
                        id: powerGraphic
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: botSysBackground
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: botPowerMenu.top//parent.bottom
                    anchors.bottomMargin: Theme.botHeight
                    width: parent.width - 15
                    height: batteryGraphic.height + bluetoothGraphic.height + audioGraphic.height + languageGraphic.height
                    radius: width / 2
                    color: Theme.colBar //Theme.nestedBackgroundElmnt 

                    Battery {
                        id: batteryGraphic
                        anchors.bottom: parent.bottom
                        //anchors.bottomMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Language {
                        id: languageGraphic
                        anchors.bottom: batteryGraphic.top
                        //anchors.bottomMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Bluetooth {
                        id: bluetoothGraphic
                        anchors.bottom: languageGraphic.top
                        //anchors.bottomMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Audio {
                        id: audioGraphic
                        anchors.bottom: bluetoothGraphic.top
                        //anchors.bottomMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Rectangle {
                    id: botDateBackground
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: botSysBackground.top//parent.bottom
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
                
                //PopupWindow {
                //    id: sysStatsPopup
                //    property bool open: false   // logical state
                //    visible: false              // actual window visibility
                //    color: "transparent"
                //
                //    implicitWidth: 300
                //    implicitHeight: 750
                //
                //    anchor.window: root
                //    anchor.rect.x: Theme.leftWidth                       // gap from ba
                //    anchor.rect.y: (root.height - implicitHeight) / 2        // vertical middle
                //
                //    // show the window immediately when opening; hide it only AFTER close anim finishes
                //    onOpenChanged: if (open) visible = true
                //
                //    Rectangle {
                //        id: content
                //        width: parent.width
                //        height: parent.height
                //        radius: 20
                //        color: Theme.colBar
                //        clip: true
                //
                //        // slides from -width (hidden) to 0 (fully shown)
                //        x: sysStatsPopup.open ? 0 : -width
                //
                //        Behavior on x {
                //            NumberAnimation {
                //                duration: 220
                //                easing.type: Easing.OutCubic
                //                onRunningChanged: {
                //                    if (!running && !sysStatsPopup.open)
                //                        sysStatsPopup.visible = false
                //                }
                //            }
                //        }
                //
                //        Column {
                //            anchors.centerIn: parent
                //            spacing: 14
                //            Cpu { anchors.horizontalCenter: parent.horizontalCenter }
                //            //Ram { anchors.horizontalCenter: parent.horizontalCenter }
                //            // Net { anchors.horizontalCenter: parent.horizontalCenter }
                //        }
                //    }
                //}
                
                //Rectangle {
                //    id: topBattery
                //    anchors.horizontalCenter: parent.horizontalCenter
                //    anchors.top: topGraphic.bottom
                //    anchors.topMargin: Theme.topHeight
                //    width: parent.width - 15
                //    height: batteryGraphic.height + 20
                //    color: Theme.nestedBackgroundElmnt
                //    radius: width / 2

                //    Battery {
                //        id: batteryGraphic
                //        anchors.top: parent.top
                //        anchors.topMargin: 10
                //        anchors.horizontalCenter: parent.horizontalCenter
                //    }
                //}

                Rectangle {
                    id: topStats
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: topGraphic.bottom
                    anchors.topMargin: Theme.topHeight
                    width: parent.width - 15
                    height: cpuGraphic.height + ramGraphic.height + diskGraphic.height + 20 + 10
                    color: Theme.nestedBackgroundElmnt
                    radius: width / 2

                    Cpu {
                        id: cpuGraphic
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Ram {
                        id: ramGraphic
                        anchors.top: cpuGraphic.bottom
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Disk {
                        id: diskGraphic
                        anchors.top: ramGraphic.bottom
                        anchors.topMargin: 5
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
                    color: Theme.colBar

                    Graphic { 
                        id: graphic 
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                   MouseArea {
                        anchors.fill: parent
                        onClicked: sysStatsPopup.open = !sysStatsPopup.open
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
