#include "base64format.h"
#include <QBuffer>
#include <QByteArray>
#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QImage>
#include <QUrl>
//#include <QtAndroidExtras>

Base64format::Base64format(QObject *parent) : QObject(parent) {}

void Base64format::handleUserProfileImage(const QString &imageUrl)
{
    QString filePath;

    QUrl url(imageUrl);

    qDebug() << "File localUrl: " << imageUrl;
    qDebug() << "File localUrl: " << url;


    if (url.isLocalFile()) {
        filePath = url.toLocalFile();
        qDebug() << "File Path:" << filePath;

        QImage image(filePath);

        if (image.isNull()) {
            qDebug() << "Failed to load the image.";
            return;
        }

        //QByteArray byteArray;
        QBuffer buffer; //(&byteArray);
        buffer.open(QIODevice::WriteOnly);
        image.save(&buffer, "PNG"); // You can replace "PNG" with the desired format

        QString base64String = buffer.data().toBase64();

        // Process the Base64 string or perform other actions
        qDebug() << "Base64 User Profile Image: " << base64String;
        emit sendBase64String(base64String);

    } /*else if(isContentUri(imageUrl)){
        qDebug() << "the url is content url";
        QAndroidJniObject uri = QAndroidJniObject::fromString(imageUrl);

        // Access Android's content resolver
        QAndroidJniObject contentResolver
            = QtAndroid::androidActivity().callObjectMethod("getContentResolver",
                                                            "()Landroid/content/ContentResolver;");

        // Get the file path from the content URI
        QAndroidJniObject contentFilePath
            = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative",
                                                        "uriToFilePath",
                                                        "(Landroid/net/Uri;)Ljava/lang/String;",
                                                        uri.object());

        filePath = contentFilePath.toString();
        qDebug() << "File path from content uri : " << filePath;

    }*/
    else {
        qDebug() << "Not a local file URL.";
    }
}

bool Base64format::isContentUri(const QString &uri)
{
    // Check if the URI starts with the "content://" scheme
    return uri.startsWith("content://");
}
