import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "ui"
import PageController 1.0
import Authentication 1.0
import ScanDevice 1.0
import ManageDevice 1.0
import Base64format 1.0

Window {
    width: 410
    height: 740
    visible: true
    id: mainWindow
    title: "gymAppTest2"

    AppPage {
        id: mainPage
        visible: true
    }

    Pageswitcher {
        id: pageloader
    }

    AuthHandler {
        id: authHandler
    }

    BLEManager {
        id: bleManager
    }

    BleScanner {
        id: bleScanner
    }
    Base64format {
        id: base64format
    }

    LoginPage {
        id: loginPage
        visible: false
    }

    SignupPage {
        id: signupPage
        visible: false
    }
    ForgetPassword {
        id: forgetPassword
        visible: false
    }
    BLEDeviceConnectPage {
        id: deviceConnectPage
        visible: false
    }
    UserInfoPage {
        id: userInfoPage
        visible: false
    }

    QuickStartPage {
        id: quickStartPage
        visible: false
    }

    HelpPage {
        id: helpPage
        visible: false
    }
}
