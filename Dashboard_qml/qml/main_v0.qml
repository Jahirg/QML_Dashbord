import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0

import QtGraphicalEffects 1.15
import "controls"
import QtQuick.Dialogs 1.3

Window {
    id: mainWindow
    width: 1000
    height: 580
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    color: "#00000000"
    title: qsTr("Dash Control ")

    // Remove title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    // Propeties
    property int windowStatus: 0
    property int windowMargin: 10

    // Text Edit Properties
    property alias actualPage: stackView.currentItem

    // Internal functions
    QtObject {
        id: internal

        function resetResizeBorders() {
            // Resize visibility
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeBottom.visible = true
            resizeWindow.visible = true
        }

        function maximizeRestore() {
            if (windowStatus == 0) {
                //mainWindow.showMaximized() // standar windows
                mainWindow.showFullScreen() // fullscreen window
                windowStatus = 1
                windowMargin = 0
                // Resize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizeWindow.visible = false
                btnMaximizeRestore.btnIconSource = "../images/svg_images/restore_icon.svg"
            } else {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximizedWindowRestore() {
            if (windowStatus == 1) {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function restoreMargins() {
            windowStatus = 0
            windowMargin = 10
            // Resize visibility
            internal.resetResizeBorders()
            btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
        }
    }

    Rectangle {
        id: bg
        color: "#2c313c"
        radius: 10
        border.color: "#383e4c"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: appContainer
            color: "#00000000"
            radius: 10
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#1c1d20"
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    y: 28
                    height: 250
                    color: "#1cfd20"
                    radius: 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.leftMargin: 60
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfo
                        color: "#B0B0B0"
                        text: qsTr("MONITOR SYS FOR ARDUINO MEGA")
                        font.bold: true
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 300
                        anchors.topMargin: 35
                        anchors.leftMargin: 10
                    }

                    Label {
                        id: labelDateInfo
                        color: "#B0B0B0"
                        text: qsTr("DATE: ")
                        font.bold: true
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 150
                        anchors.topMargin: 35
                    }

                    Label {
                        id: labelRightInfo
                        color: "#B0B0B0"
                        text: qsTr("| HOME")
                        anchors.right: parent.right
                        font.bold: true
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 10
                        anchors.topMargin: 35
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if (active) {
                                             mainWindow.startSystemMove()
                                             internal.ifMaximizedWindowRestore()
                                         }
                    }

                    Image {
                        id: iconApp
                        width: 32
                        height: 32
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/chip.png"
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        color: "#00A5FF"
                        text: qsTr("DASHBOARD CONTROL")
                        anchors.left: iconApp.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 20
                        font.bold: true
                        anchors.leftMargin: 5
                    }
                }

                Row {
                    id: rowBtns
                    x: 872
                    width: 220
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    ///
                    SwitchDelegate {
                        id: control
                        text: qsTr("SD")
                        checked: false
                        font.pointSize: 14
                        height: 25
                        anchors.top: parent.top
                        anchors.topMargin: 5

                        contentItem: Text {
                            rightPadding: control.indicator.width + control.spacing
                            text: control.text
                            font: control.font
                            opacity: enabled ? 1.0 : 0.3
                            color: control.down ? "#AEFF00" : "#AEFF00"
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        indicator: Rectangle {
                            implicitWidth: 48
                            implicitHeight: 26
                            x: control.width - width - control.rightPadding
                            y: parent.height / 2 - height / 2
                            radius: 13
                            color: control.checked ? "#ffae00" : "transparent"
                            border.color: control.checked ? "#ffae00" : "#cccccc"

                            Rectangle {
                                x: control.checked ? parent.width - width : 0
                                width: 26
                                height: 26
                                radius: 13
                                color: control.down ? "#c0c0c0" : "#f0f0f0"
                            }
                        }
                        background: Rectangle {
                            implicitWidth: 80
                            implicitHeight: 40
                            visible: control.down || control.highlighted
                            color: "#00000000"
                        }
                    }

                    ///
                    TopBarButton {
                        id: btnMinimize
                        btnColorDefault: "#00d000"
                        btnColorMouseOver: "#00f000"
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    TopBarButton {
                        id: btnMaximizeRestore
                        btnColorDefault: "#ffa500"
                        btnColorMouseOver: "#FFBE47"
                        btnIconSource: "../images/svg_images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: btnClose
                        btnColorClicked: "#ff007f"
                        btnColorDefault: "#F23F04"
                        btnColorMouseOver: "#ff6060"
                        btnIconSource: "../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 60
                    color: "#1c1d20"
                    radius: 10
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0

                    PropertyAnimation {
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if (leftMenu.width == 60)
                                return 150
                            else
                                return 60
                        duration: 500
                        easing.type: Easing.InOutQuint
                    }

                    Column {
                        id: columnMenus
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        clip: true
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenuBtn {
                            id: btnHome
                            width: leftMenu.width
                            text: "<font color='#b0b0b0'>" + "Home" + "</font>"
                            font.bold: true
                            font.pointSize: 12
                            //isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu = true
                                btnOpen.isActiveMenu = false
                                btnSave.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl(
                                                   "pages/homePage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnOpen
                            width: leftMenu.width
                            text: "<font color='#b0b0b0'>" + "Open" + "</font>"
                            font.bold: true
                            font.pointSize: 12
                            btnIconSource: "../images/svg_images/open_icon.svg"

                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnOpen.isActiveMenu = true
                                btnSave.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl(
                                                   "pages/openPage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnSave
                            width: leftMenu.width
                            text: "<font color='#b0b0b0'>" + "Save" + "</font>"
                            font.bold: true
                            font.pointSize: 12
                            btnIconSource: "../images/svg_images/save_icon.svg"

                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnOpen.isActiveMenu = false
                                btnSave.isActiveMenu = true
                                btnSettings.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl(
                                                   "pages/savePage.qml"))
                            }
                        }
                    }

                    LeftMenuBtn {
                        id: btnSettings
                        width: leftMenu.width
                        text: "<font color='#b0b0b0'>" + "Settings" + "</font>"
                        font.bold: true
                        font.pointSize: 12
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        btnIconSource: "../images/svg_images/settings_icon.svg"
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnOpen.isActiveMenu = false
                            btnSave.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            stackView.push(Qt.resolvedUrl(
                                               "pages/settingsPage.qml"))
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#00000000"
                    radius: 10
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0
                    StackView {
                        id: stackView
                        anchors.fill: parent
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        initialItem: Qt.resolvedUrl("pages/iniPage.qml")
                    }
                }

                Rectangle {
                    id: rectangle
                    color: "#282c34"
                    radius: 10
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Label {
                        id: labelTopInfo1
                        color: "#B0B0B0"
                        text: qsTr("By: JJGM")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.topMargin: 0
                        anchors.rightMargin: 30
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 0
                    }
                    Label {
                        id: labelTopInfo2
                        color: "#B0B0B0"
                        text: qsTr(" ")
                        anchors.left: parent.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.topMargin: 0
                        anchors.rightMargin: 25
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }

                    MouseArea {
                        id: resizeWindow
                        x: 884
                        y: 0
                        width: 25
                        height: 25
                        opacity: 0.5
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler {
                            target: null
                            onActiveChanged: if (active) {
                                                 mainWindow.startSystemResize(
                                                             Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }

                        Image {
                            id: resizeImage
                            width: 16
                            height: 16
                            anchors.fill: parent
                            source: "../images/svg_images/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }
            }
        }
    }

    DropShadow {
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z: 0
    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.LeftEdge)
                             }
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.RightEdge)
                             }
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {
                                 mainWindow.startSystemResize(Qt.BottomEdge)
                             }
        }
    }

    Connections {
        target: backend
        function onReadText(text) {
            actualPage.setText = text
        }
        function onPrintHour(hour) {
            labelTopInfo2.text = "TIME | " + hour
        }
        function onPrintDate(date) {
            labelDateInfo.text = "DATE | " + date
        }
    }
}
