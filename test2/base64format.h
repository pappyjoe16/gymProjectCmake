#ifndef BASE64FORMAT_H
#define BASE64FORMAT_H

#include <QObject>
#include <QString>

class Base64format : public QObject
{
    Q_OBJECT
public:
   explicit Base64format(QObject *parent = nullptr);

public slots:
    void handleUserProfileImage(const QString &imageUrl);
    bool isContentUri(const QString& uri);

signals:
    void sendBase64String(const QString base64String);


};

#endif // BASE64FORMAT_H
