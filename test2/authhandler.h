#ifndef AUTHHANDLER_H
#define AUTHHANDLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>

class AuthHandler : public QObject
{
    Q_OBJECT
public:
    explicit AuthHandler(QObject *parent = nullptr);
    ~AuthHandler();
    Q_INVOKABLE void setAPIKey(const QString &apiKey);
    Q_INVOKABLE void signUserUp(const QString &emailAddress, const QString &password);
    Q_INVOKABLE void signUserIn(const QString &emailAddress, const QString &password);
    Q_INVOKABLE void getRestCode(const QString &emailAddress);

    
public slots:
    void networkReplyReadyRead(const QString &errorCheck);
    
signals:
    void userSignedIn();
    void resetErrorSignal(QString resetErrorMessage);
    void signInErrorSignal(QString signInErrorMessage);
    void signUpErrorSignal(QString signUpErrorMessage);

    
private:
    void performPOST(const QString &url, const QJsonDocument &payload, const QString &errorCheck);
    void parseResponse(const QByteArray &response, const QString &errorCheck);

    QString m_apiKey;
    QNetworkAccessManager * m_networkAccessManager;
    QNetworkReply * m_networkReply;
    QString m_idToken;

};

#endif // AUTHHANDLER_H
