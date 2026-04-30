// Theme.qml
pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property color colBar: "#191724"
    readonly property color colText: "#e0def4"
    readonly property string fontFamily: "Hack Nerd Font"
    readonly property int fontSize: 18
    readonly property int barRadius: 15
    readonly property color colPower: "#eb6f92"

    // bar width
    readonly property int rightWidth: 10
    readonly property int leftWidth: 55
    readonly property int topHeight: 10
    readonly property int botHeight: 10

    // icons
    readonly property FontLoader materialSymbols: FontLoader {
        source: Qt.resolvedUrl("fonts/Material_Symbols_Outlined/MaterialSymbolsOutlined-VariableFont_FILL,GRAD,opsz,wght.ttf")
    }

    readonly property string iconFont: materialSymbols.name

    // sidebar nested background
    readonly property string nestedBackgroundElmnt: "#2a273f"


    // icon
    readonly property string colIcon: "#f6c177"
    // sys
    readonly property string colCpu: "#31748f"
    readonly property string colRam: "#9ccfd8"
    readonly property string colDisk: "#c4a7e7"

}
