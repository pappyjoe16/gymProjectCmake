import QtQuick 2.15
import QtQuick.Controls 2.15

Image {
    id: backgroundImage1
    width: 410
    height: 740
    anchors.fill: parent
    source: "qrc:/ui/assets/images/01.jpeg"
    anchors.rightMargin: 0
    anchors.bottomMargin: 0
    anchors.leftMargin: 0
    anchors.topMargin: 0
    layer.enabled: false
    opacity: 1
    z: -1
    fillMode: Image.Stretch

    Button {
        id: login
        //y: 662
        height: 68
        text: qsTr("Login")
        font.underline: false
        font.italic: false
        font.pointSize: 15
        font.bold: true
        font.family: "Tahoma"
        highlighted: true
        flat: false
        anchors.bottomMargin: 230
        onClicked: pageloader.pageLoader("login")

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            rightMargin: 38
            leftMargin: 39
        }
    }

    Button {
        id: signUp
        y: 736
        height: 63
        text: qsTr("Email register")
        font.family: "Tahoma"
        font.bold: true
        font.italic: false
        font.pointSize: 15
        highlighted: false
        anchors.bottomMargin: 161
        onClicked: pageloader.pageLoader("signup")
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            rightMargin: 39
            leftMargin: 39
        }
    }

    Button {
        id: forgetPasswordBtn
        y: 827
        height: 42
        text: qsTr("Forget password?")
        //color: "#f9f3e4e4"
        highlighted: true
        font.bold: false
        flat: true
        font.underline: true
        font.italic: true
        font.pointSize: 14
        anchors.bottomMargin: 100
        onClicked: pageloader.pageLoader("forgetPassword")
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            rightMargin: 123
            leftMargin: 123
        }
    }
    Connections {
        target: pageloader
        function onSwitchToLoginPage() {
            mainPage.visible = false
            loginPage.visible = true
        }
    }
    Connections {
        target: pageloader
        function onSwitchToSignupPage() {
            mainPage.visible = false
            signupPage.visible = true
        }
    }
    Connections {
        target: pageloader
        function onSwitchToForgetPassword() {
            mainPage.visible = false
            forgetPassword.visible = true
        }
    }
}
