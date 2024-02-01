import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rectangle
    width: 410
    height: 740
    color: "#000000"
    anchors.fill: parent
    anchors.rightMargin: 0
    anchors.bottomMargin: 0
    anchors.leftMargin: 0
    anchors.topMargin: 0

    Button {
        id: backButton
        height: 38
        palette.buttonText: "white"
        icon.source: "qrc:/ui/assets/images/backArrow.png"
        icon.height: parent.height
        icon.width: parent.width
        font.family: "Tahoma"
        highlighted: true
        flat: false
        anchors.topMargin: 16
        onClicked: pageloader.pageLoader("backToConnect")

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 347
            leftMargin: 4
        }
    }
    Label {
        id: pageTitleLabel
        height: 37
        color: "#ffffff"
        text: qsTr("Help")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 156
        anchors.rightMargin: 156
        anchors.topMargin: 14
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.pointSize: 18
        font.italic: true
    }

    Label {
        id: intructLabel
        height: 82
        color: "#ffffff"
        text: qsTr("Wearing the sensor correctly will \n increace the accuracy of the\n device.")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 46
        anchors.rightMargin: 46
        anchors.topMargin: 71
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.pointSize: 15
        font.italic: true
    }

    Label {
        id: oneLable
        x: -2
        y: -2
        height: 110
        color: "#ffffff"
        text: qsTr("1. Put the sensor into the strap (The\n arrow is facing forward), please pay\n attention to symbol \"L\" (left) and\n \"R\" (right) when wearing.")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: intructLabel.bottom
        anchors.leftMargin: 39
        anchors.rightMargin: 46
        anchors.topMargin: 27
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 15
        font.italic: true
        font.bold: true
    }

    Image {
        id: image
        height: 122
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: oneLable.bottom
        anchors.leftMargin: 39
        anchors.rightMargin: 46
        anchors.topMargin: 13
        source: "qrc:/ui/assets/images/helpImage1.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image1
        height: 122
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: twoLabel.bottom
        anchors.leftMargin: 54
        anchors.rightMargin: 66
        anchors.topMargin: 11
        source: "qrc:/ui/assets/images/helpImage2.png"
        fillMode: Image.PreserveAspectFit
    }

    Label {
        id: twoLabel
        x: 3
        y: 3
        height: 55
        color: "#ffffff"
        text: qsTr("2. Adjust the lenght of the strap, and tie\n it comfortably to your wrist.")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: image.bottom
        anchors.leftMargin: 16
        anchors.rightMargin: 23
        anchors.topMargin: 18
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 15
        font.italic: true
        font.bold: true
    }

    Button {
        id: doneButton
        y: 648
        height: 52
        text: qsTr("Done")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 43
        anchors.rightMargin: 55
        anchors.bottomMargin: 40
        font.bold: true
        font.italic: true
        font.pointSize: 17
        icon.width: 24
        highlighted: true
        onClicked: pageloader.pageLoader("backToConnect")
    }

    Connections {
        target: pageloader
        function onSwitchBackToConnectPage() {
            deviceConnectPage.visible = true
            helpPage.visible = false
        }
    }
}
