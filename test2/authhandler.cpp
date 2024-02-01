#include "authhandler.h"
#include <QDebug>
#include <QVariantMap>
#include <QNetworkRequest>
// #include <QSslKey>
// #include <QSslSocket>
#include <QJsonObject>

AuthHandler::AuthHandler(QObject *parent)
    : QObject{parent}
    , m_apiKey(QString())

{
    m_networkAccessManager = new QNetworkAccessManager (this);
    //qDebug() << " I am created 3333";
}

AuthHandler::~AuthHandler()
{
    m_networkAccessManager->deleteLater();
    //qDebug() << " I am deconstructed 3333";
}

void AuthHandler::setAPIKey(const QString &apiKey)
{
    m_apiKey = apiKey;
    //qDebug() << " I am click from signup "<< apiKey ;
}

void AuthHandler::signUserUp(const QString &emailAddress, const QString &password)
{
    // qInfo() << QSslSocket::sslLibraryBuildVersionString();
    // qInfo() << QSslSocket::sslLibraryVersionString();
    // qDebug() << "Device supports OpenSSL: " << QSslSocket::supportsSsl();
    QString signUpEndPoint  = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + m_apiKey;
    
    QVariantMap variantPayload;
    variantPayload["email"] = emailAddress;
    variantPayload["password"] = password;
    variantPayload["returnSecureToken"] = true;
    
    QJsonDocument jsonPayload = QJsonDocument::fromVariant(variantPayload);
    performPOST(signUpEndPoint, jsonPayload, QString ("signup"));

    //qDebug() << " I am click from signup "<< emailAddress << password;

}

void AuthHandler::signUserIn(const QString &emailAddress, const QString &password)
{
    QString signInEndPoint  = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + m_apiKey;

    QVariantMap variantPayload;
    variantPayload["email"] = emailAddress;
    variantPayload["password"] = password;
    variantPayload["returnSecureToken"] = true;

    QJsonDocument jsonPayload = QJsonDocument::fromVariant(variantPayload);
    performPOST(signInEndPoint, jsonPayload, QString ("signin"));

    //qDebug() << " I am click from signin "<< emailAddress << password;
}

void AuthHandler::networkReplyReadyRead(const QString &errorCheck)
{
    //qInfo() << m_networkReply->readAll();
    QByteArray response =  m_networkReply->readAll();
    m_networkReply->deleteLater();

    parseResponse(response, errorCheck);
}

void AuthHandler::performPOST(const QString &url, const QJsonDocument &payload, const QString &errorCheck)
{
    QNetworkRequest newRequest((QUrl(url)));
    newRequest.setHeader(QNetworkRequest::ContentTypeHeader, QString("application/json"));
    m_networkReply = m_networkAccessManager->post(newRequest, payload.toJson());
    connect(m_networkReply, &QNetworkReply::readyRead, this, [=]() {
        networkReplyReadyRead(errorCheck);
    });
}

void AuthHandler::parseResponse(const QByteArray &response, const QString &errorCheck)
{
    QJsonDocument jsonDocument = QJsonDocument::fromJson(response);
    if(jsonDocument.object().contains("error"))
    {
        QJsonObject errorObject = jsonDocument["error"].toObject();
        QString errorMessage = errorObject["message"].toString();
        qDebug() << "Error occured!" << errorMessage ;

        if(errorCheck =="signup"){
            emit signUpErrorSignal(errorMessage);
        }else if(errorCheck =="signin"){
            if (errorMessage == "TOO_MANY_ATTEMPTS_TRY_LATER : Access to this account has been "
                                "temporarily disabled due to many failed login attempts. You can "
                                "immediately restore it by resetting your password or you can try "
                                "again later.")
            {
                emit signInErrorSignal(QString("TOO_MANY_ATTEMPTS_TRY_LATER"));
            }else{
                emit signInErrorSignal(errorMessage);
            }
        }else if(errorCheck =="resetPassword"){
            emit resetErrorSignal(errorMessage);
        }


    } else if (jsonDocument.object().contains("kind"))
    {
        QString idToken = jsonDocument.object().value("idToken").toString();
        //qDebug() << "Obtained user ID Token: "<< idToken;
        m_idToken = idToken;
        if(errorCheck =="signup"){
            emit signUpErrorSignal(QString("SUCCESS"));
        }else if(errorCheck =="signin")
        {
            emit signInErrorSignal(QString("SUCCESS"));
        }else if(errorCheck =="resetPassword"){
            emit resetErrorSignal(QString("SUCCESS"));
        }

    }
}

void AuthHandler::getRestCode(const QString &emailAddress)
{
    QString resetPasswordEndPoint  = "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=" + m_apiKey;

    QVariantMap variantPayload;
    variantPayload["requestType"] = "PASSWORD_RESET";
    variantPayload["email"] = emailAddress;

    QJsonDocument jsonPayload = QJsonDocument::fromVariant(variantPayload);
    performPOST(resetPasswordEndPoint, jsonPayload, QString ("resetPassword"));

    //qDebug() << " I am click from signin "<< emailAddress ;
}
