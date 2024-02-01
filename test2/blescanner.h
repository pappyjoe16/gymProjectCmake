// blescanner.h
#ifndef BLESCANNER_H
#define BLESCANNER_H

#include <QObject>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothDeviceInfo>

class BleScanner : public QObject
{
    Q_OBJECT
public:
    explicit BleScanner(QObject *parent = nullptr);
    ~BleScanner();

signals:
    void deviceDiscovered(const QBluetoothDeviceInfo &deviceInfo);
    void devicesListUpdated(const QStringList &devices);

public slots:
    void startScan();
    void stopScan();

private slots:
    void deviceDiscoveredHandler(const QBluetoothDeviceInfo &deviceInfo);

private:
    QBluetoothDeviceDiscoveryAgent *discoveryAgent;
    QStringList discoveredDevices;
};

#endif // BLESCANNER_H
