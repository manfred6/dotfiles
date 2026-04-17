// Theme.qml
pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property color colBar: "#000000"
    readonly property color colText: "#ffffff"
    readonly property string fontFamily: "Hack Nerd Font"
    readonly property int fontSize: 18
    readonly property int barRadius: 25

    // bar width
    readonly property int rightWidth: 10
    readonly property int leftWidth: 50
    readonly property int topHeight: 10
    readonly property int botHeight: 10

    // icons
    readonly property FontLoader materialSymbols: FontLoader {
        source: Qt.resolvedUrl("fonts/MaterialSymbolsOutlined.ttf")
    }

    readonly property string iconFont: materialSymbols.name

    // sidebar nested background
    readonly property string nestedBackgroundElmnt: "#2a2a2a"
}
