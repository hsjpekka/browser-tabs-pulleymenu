import QtQuick 2.0
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0

Page {
    id: page
    allowedOrientations: Orientation.All
    Component.onCompleted: {
        var value, sign = 1
        if (pulleyLocations.value < 0) {
            toolBar.checked = true
            sign = -1
        }
        value = pulleyLocations.value * sign
        if (value < 1.5) {
            bottomMenu.checked = true
            topMenu.checked = false
        } else if (value < 2.5) {
            bottomMenu.checked = false
            topMenu.checked = true
        } else {
            bottomMenu.checked = true
            topMenu.checked = true
        }
    }

    ConfigurationValue {
        id: pulleyLocations
        key: "/apps/patchmanager/browser-tabs-pulley-menu/locations"
        defaultValue: 1 // 1 - bottom, 2 - top, 3 - top & bottom, negative values don't hide the tool bar
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator{}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader {
                title: qsTr("Pulley menus on the tabs view")
            }

            Label {
                text: qsTr("Adds PullDown & PushUp menus on the tabs view of the browser and removes the tool bar.")
                color: Theme.highlightColor
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                width: parent.width - 2*x
                x: Theme.horizontalPageMargin
            }

            TextSwitch {
                id: bottomMenu
                text: checked? qsTr("PushUpMenu shown.") : qsTr("PushUpMenu not shown.")
                checked: false
				onCheckedChanged: {
                    storeLocation()
				}
            }

            TextSwitch {
                id: topMenu
                text: checked? qsTr("PullDownMenu shown.") : qsTr("PullDownMenu not shown.")
                checked: false
                onCheckedChanged: {
                    storeLocation()
                }
            }

            TextSwitch {
                id: toolBar
                text: checked? qsTr("ToolBar shown.") : qsTr("ToolBar not shown.")
                checked: false
                onCheckedChanged: {
                    storeLocation()
                }
            }

            Label {
                text: qsTr("Modifies %1 in %2.").arg("TabView.qml").arg("/usr/share/sailfish-browser/pages/components")
                color: Theme.highlightColor
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                width: parent.width - 2*x
                x: Theme.horizontalPageMargin
            }
        }
    }

    function storeLocation() {
        var sign, value = toolBar.checked? -1 : 1

        if (toolBar.checked) {
            sign = -1
        } else {
            sign = 1
        }

        if (bottomMenu.checked) {
            value = 1
        } else {
            value = 0
        }

        if (topMenu.checked) {
            value += 2
        }

        pulleyLocations.value = value * sign;
        pulleyLocations.sync();

        return;
    }
}
