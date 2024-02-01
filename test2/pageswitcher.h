#ifndef PAGESWITCHER_H
#define PAGESWITCHER_H

#include <QObject>

class Pageswitcher : public QObject
{
    Q_OBJECT
public:
    explicit Pageswitcher(QObject *parent = nullptr);
    ~Pageswitcher();
    Q_INVOKABLE void pageLoader(QString page);


signals:
    void switchToLoginPage();
    void switchToSignupPage();
    void switchToAppPage();
    void switchToForgetPassword();
    void switchToHelpPage();
    void switchToConnectPage();
    void switchBackToConnectPage();
    void switchToQuickstart();


public slots:

};

#endif // PAGESWITCHER_H
