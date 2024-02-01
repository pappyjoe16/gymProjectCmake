import QtCore
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

Rectangle {
    id: rectangle
    width: 410
    height: 740
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#100412"
        }

        GradientStop {
            position: 0.58579
            color: "#93676b"
        }

        GradientStop {
            position: 0.92544
            color: "#670505"
        }
        orientation: Gradient.Vertical
    }
    anchors.fill: parent
    anchors.rightMargin: 0
    anchors.bottomMargin: 0
    anchors.leftMargin: 0
    anchors.topMargin: 0

    Button {
        id: profileButton
        height: 48
        text: qsTr("Upload")
        anchors.topMargin: 157
        font.pointSize: 11
        checkable: true
        onClicked: fileDialog.open()
        anchors {
            left: profileImage.right
            right: parent.right
            top: parent.top
            rightMargin: 40
            leftMargin: 7
        }
    }

    Image {
        id: profileImage
        height: 120
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 145
        anchors.rightMargin: 145
        anchors.topMargin: 85
        source: "qrc:/ui/assets/images/default-image.jpg"
        fillMode: Image.PreserveAspectFit
    }

    FileDialog {
        id: fileDialog
        title: "Select an image"
        //folder: shortcuts.home
        nameFilters: ["Image files (*.png *.jpg *.jpeg)"]
        currentFolder: StandardPaths.standardLocations(
                           StandardPaths.PicturesLocation)[0]
        // onAccepted: profileImage.source = selectedFile
        onAccepted: {
            var fileUrl = fileDialog.selectedFile
            if (fileUrl !== "") {
                profileImage.source = selectedFile
                base64format.handleUserProfileImage(profileImage.source)
            }
        }
        onRejected: {
            console.log("Dialog rejected")
        }
    }

    Label {
        id: profile
        width: 144
        height: 26
        color: "#ffffff"
        text: qsTr("Profile")
        horizontalAlignment: Text.AlignHCenter
        layer.mipmap: true
        font.weight: Font.Bold
        font.pointSize: 32
        font.bold: true
        font.family: "Times New Roman"
        anchors.topMargin: 34
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 89
            leftMargin: 89
        }
    }

    TextField {
        id: userNameField
        x: 47
        y: 247
        width: 317
        height: 36
        placeholderText: qsTr("Enter your name")
        placeholderTextColor: "#100412"
        font.pixelSize: 18
        maximumLength: 100
        echoMode: TextInput.Normal

        anchors.topMargin: 233
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 46
            leftMargin: 40
        }

        background: Item {
            width: parent.width
            height: parent.height

            Rectangle {
                width: parent.width
                height: parent.height
                color: "#ffffff"
                radius: 15
                opacity: 1
            }
        }
        font.preferShaping: false
        onAccepted: genderBox.pressed
        cursorVisible: true
    }

    ComboBox {
        id: genderBox
        height: 36

        textRole: "text"
        valueRole: "value"
        font.pixelSize: 18
        anchors.topMargin: 267
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 46
            leftMargin: 40
        }
        background: Item {
            width: parent.width
            height: parent.height

            Rectangle {
                width: parent.width
                height: parent.height
                color: "#ffffff"
                radius: 15
                opacity: 1
            }
        }
        model: [{
                "value": Qt.NoModifier,
                "text": qsTr("select gender")
            }, {
                "value": Qt.ShiftModifier,
                "text": qsTr("male")
            }, {
                "value": Qt.ShiftModifier,
                "text": qsTr("female")
            }, {
                "value": Qt.ShiftModifier,
                "text": qsTr("other")
            }]
    }

    ComboBox {
        id: ageBox
        height: 36
        anchors.topMargin: 311
        font.pixelSize: 18
        valueRole: "value"
        textRole: "text"
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 46
            leftMargin: 40
        }
        model: (function () {
            var data = []
            data.push({
                          "value": Qt.NoModifier,
                          "text": qsTr("select age")
                      })
            for (var i = 10; i <= 100; i++) {
                data.push({
                              "value": Qt.ShiftModifier,
                              "text": qsTr(i.toString() + " years")
                          })
            }
            return data
        })()

        background: Item {
            width: parent.width
            height: parent.height
            Rectangle {
                width: parent.width
                height: parent.height
                opacity: 1
                color: "#ffffff"
                radius: 15
            }
        }
    }

    ComboBox {
        id: heightBox
        height: 36

        anchors.topMargin: 354
        font.pixelSize: 18
        valueRole: "value"
        textRole: "text"
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 46
            leftMargin: 40
        }
        model: (function () {
            var data = []
            data.push({
                          "value": Qt.NoModifier,
                          "text": qsTr("select height")
                      })
            for (var i = 150; i <= 230; i++) {
                data.push({
                              "value": Qt.ShiftModifier,
                              "text": qsTr(i.toString() + " cm")
                          })
            }
            return data
        })()

        background: Item {
            width: parent.width
            height: parent.height
            Rectangle {
                width: parent.width
                height: parent.height
                opacity: 1
                color: "#ffffff"
                radius: 15
            }
        }
    }
    ComboBox {
        id: weightBox
        height: 36
        anchors.topMargin: 398
        font.pixelSize: 18
        valueRole: "value"
        textRole: "text"
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 46
            leftMargin: 40
        }
        model: (function () {
            var data = []
            data.push({
                          "value": Qt.NoModifier,
                          "text": qsTr("select weight")
                      })
            for (var i = 35; i <= 150; i++) {
                data.push({
                              "value": Qt.ShiftModifier,
                              "text": qsTr(i.toString() + " KG")
                          })
            }
            return data
        })()

        background: Item {
            width: parent.width
            height: parent.height
            Rectangle {
                width: parent.width
                height: parent.height
                opacity: 1
                color: "#ffffff"
                radius: 15
            }
        }
    }
    ComboBox {
        id: handBox
        height: 36
        anchors.topMargin: 441
        textRole: "text"
        valueRole: "value"
        font.pixelSize: 18
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 46
            leftMargin: 40
        }
        background: Item {
            width: parent.width
            height: parent.height

            Rectangle {
                width: parent.width
                height: parent.height
                color: "#ffffff"
                radius: 15
                opacity: 1
            }
        }
        model: [{
                "value": Qt.NoModifier,
                "text": qsTr("select hand habit")
            }, {
                "value": Qt.ShiftModifier,
                "text": qsTr("Right handed")
            }, {
                "value": Qt.ShiftModifier,
                "text": qsTr("Left handed")
            }]
    }

    Item {
        id: __materialLibrary__
    }

    Image {
        id: baseImage
        y: 688
        height: 52
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        source: "qrc:/ui/assets/images/svg.png"
        fillMode: Image.PreserveAspectFit
    }

    Button {
        id: signUp
        y: 554
        height: 63
        text: qsTr("Save profile")
        font.family: "Tahoma"
        font.bold: true
        font.italic: false
        font.pointSize: 15
        highlighted: false
        anchors.bottomMargin: 143
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            rightMargin: 89
            leftMargin: 86
        }
        onClicked: {
            if (userNameField.text.trim() == ""
                    || genderBox.currentText == "select gender"
                    || ageBox.currentText == "select age"
                    || heightBox.currentText == "select height"
                    || weightBox.currentText == "select weight"
                    || handBox.currentText == "select hand habit") {
                errorPopup.text = "All fields are required."
                errorPopup.open()
            } else {
                console.log("Your details are as following: " + userNameField.text + "\t"
                            + genderBox.currentText + "\t" + ageBox.currentText
                            + "\t" + heightBox.currentText + "\t"
                            + weightBox.currentText + "\t" + handBox.currentText)
            }
        }
    }
    Popup {
        id: errorPopup
        width: 280
        height: 70
        contentItem: Rectangle {
            color: "lightgray"
            Label {
                anchors.centerIn: parent
                font.pointSize: 11.5
                color: "red"
                text: errorPopup.text
            }
        }
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        onOpened: {
            closeTimer.restart()
        }
        Timer {
            id: closeTimer
            interval: 3000 // 3000 milliseconds (2 seconds)
            onTriggered: errorPopup.close()
        }
        property string text: "" // Property to dynamically set the error message text
    }

    Connections {
        target: base64format
        function onSendBase64String(base64String) {
            var qmBbase64String = base64String
            baseImage.source = "data:image/png;base64," + qmBbase64String
        }
    }
}
