#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "pageswitcher.h"
#include "authhandler.h"
#include "blemanager.h"
#include "blescanner.h"
#include <QSslKey>
#include <QSslSocket>
#include "base64format.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //Pageswitcher pageControl;
    //AuthHandler authHandler;

    qmlRegisterType<Base64format>("Base64format", 1, 0, "Base64format");
    qmlRegisterType<BleScanner>("ScanDevice", 1, 0, "BleScanner");
    qmlRegisterType<BLEManager>("ManageDevice", 1, 0, "BLEManager");
    qmlRegisterType<Pageswitcher>("PageController", 1, 0, "Pageswitcher");
    qmlRegisterType<AuthHandler>("Authentication", 1, 0, "AuthHandler");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);
    //QQmlContext * rootContext = engine.rootContext();
    //rootContext->setContextProperty("myClass", &pageControl);



    return app.exec();
}
