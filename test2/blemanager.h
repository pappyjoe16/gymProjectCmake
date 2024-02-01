// blemanager.h
#ifndef BLEMANAGER_H
#define BLEMANAGER_H

#include <QObject>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QLowEnergyController>

class BLEManager : public QObject
{
    Q_OBJECT
public:
    explicit BLEManager(QObject *parent = nullptr);

public slots:
    void connectToLeftTracker();
    void connectToRightTracker();

private slots:
    void connectToDevice(const QString &deviceName);
    void deviceDiscovered(const QBluetoothDeviceInfo &info);
    void deviceConnected();
    void deviceDisconnected();
    void serviceDiscovered(const QBluetoothUuid &serviceUuid);
    void characteristicChanged(const QLowEnergyCharacteristic &characteristic, const QByteArray &value);

private:
    QBluetoothDeviceDiscoveryAgent *discoveryAgent;
    QLowEnergyController *bleController;
    QLowEnergyService *bleService;
    QLowEnergyCharacteristic *leftCharacteristic;
    QLowEnergyCharacteristic *rightCharacteristic;

    void setupCharacteristics();
};

#endif // BLEMANAGER_H
