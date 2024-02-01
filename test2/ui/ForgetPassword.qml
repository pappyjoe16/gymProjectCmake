import QtQuick 2.15
import QtQuick.Controls 2.15

Image {
    id: backgroundImage1
    width: 410
    height: 740
    anchors.fill: parent
    source: "qrc:/ui/assets/images/backgnd7.jpg"
    anchors.rightMargin: 0
    anchors.bottomMargin: 0
    anchors.leftMargin: 0
    anchors.topMargin: 0
    layer.enabled: false
    opacity: 1
    z: -1
    fillMode: Image.Stretch

    Button {
        id: backButton
        height: 45
        palette.buttonText: "white"
        icon.source: "qrc:/ui/assets/images/backArrow.png"
        icon.height: parent.height
        icon.width: parent.width
        font.family: "Tahoma"
        highlighted: true
        flat: false
        anchors.topMargin: 14

        onClicked: pageloader.pageLoader("backHome")
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 325
            leftMargin: 4
        }
    }

    TextField {
        id: emailAddress
        x: 89
        y: 218
        width: 362
        height: 54
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        maximumLength: 100
        renderType: Text.QtRendering
        mouseSelectionMode: TextInput.SelectCharacters
        echoMode: TextInput.Normal
        placeholderText: "Email Address"
        color: "#330000"
        anchors.topMargin: 210
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 39
            leftMargin: 39
        }

        background: Item {
            width: parent.width
            height: parent.height

            Rectangle {
                width: parent.width
                height: parent.height
                color: "#ffffff"
                radius: 15
                border.width: 4
                border.color: "#330000"
            }
        }
    }

    Button {
        id: getResetCode
        height: 45
        palette.buttonText: "white"
        text: qsTr("Send")
        font.family: "Tahoma"
        highlighted: true
        flat: false
        anchors.topMargin: 272
        onClicked: {
            if (emailAddress.text.trim() == "") {
                errorPopup.text = "Registered Email is required."
                errorPopup.open()
            } else {
                authHandler.setAPIKey("AIzaSyAiBfude-2sHoh7qPj_lVxhD5xSxtfSozk")
                authHandler.getRestCode(emailAddress.text)
            }
        }
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 80
            leftMargin: 80
        }
    }

    Label {
        id: label
        x: 198
        y: 155
        width: 144
        height: 26
        color: "white"
        text: qsTr("Forget password?")
        horizontalAlignment: Text.AlignHCenter
        layer.mipmap: true
        font.weight: Font.Bold
        font.pointSize: 24
        font.bold: true
        font.family: "Times New Roman"
        font.italic: true
        anchors.topMargin: 165
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            rightMargin: 89
            leftMargin: 89
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
        // Center the popup on the screen
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        // Close the popup after a short delay
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
        target: pageloader
        function onSwitchToAppPage() {
            mainPage.visible = true
            forgetPassword.visible = false
        }
    }
    Connections {
        target: pageloader
        function onSwitchToLoginPage() {
            loginPage.visible = true
            forgetPassword.visible = false
        }
    }

    Connections {
        target: authHandler
        function onResetErrorSignal(resetErrorMessage) {
            //console.log("Error message received:", errorMessage)
            if (resetErrorMessage == "SUCCESS") {
                errorPopup.text = "Reset password link sent to your Email\n   follow the link to reset password"
                errorPopup.open()
                pageloader.pageLoader("login")
            } else if (resetErrorMessage == "INVALID_EMAIL") {
                errorPopup.text = "       Error Occured \nYou Enter an Invalid Email"
                errorPopup.open()
            }
        }
    }
}
