// blemanager.cpp
#include "blemanager.h"

BLEManager::BLEManager(QObject *parent) : QObject(parent)
{
    discoveryAgent = new QBluetoothDeviceDiscoveryAgent(this);
    bleController = nullptr; // Initialize to nullptr

    connect(discoveryAgent, &QBluetoothDeviceDiscoveryAgent::deviceDiscovered,
            this, &BLEManager::deviceDiscovered);
}

void BLEManager::connectToLeftTracker()
{
    connectToDevice("LeftTracker");
}

void BLEManager::connectToRightTracker()
{
    connectToDevice("RightTracker");
}

void BLEManager::connectToDevice(const QString &deviceName)
{
    if (bleController) {
        // Clean up previous controller
        bleController->disconnectFromDevice();
        bleController->deleteLater();
    }

    QList<QBluetoothDeviceInfo> devices = discoveryAgent->discoveredDevices();
    QBluetoothDeviceInfo selectedDevice;

    // Find the device with the specified name
    for (const auto &device : devices) {
        if (device.name() == deviceName) {
            selectedDevice = device;
            break;
        }
    }

    if (!selectedDevice.isValid()) {
        qDebug() << "Device not found.";
        return;
    }

    bleController = QLowEnergyController::createCentral(selectedDevice, this);

    connect(bleController, &QLowEnergyController::connected,
            this, &BLEManager::deviceConnected);
    connect(bleController, &QLowEnergyController::disconnected,
            this, &BLEManager::deviceDisconnected);

    bleController->connectToDevice();
}

void BLEManager::deviceDiscovered(const QBluetoothDeviceInfo &info)
{
    qDebug() << "Discovered device:" << info.name();
}

void BLEManager::deviceConnected()
{
    qDebug() << "Device connected.";

    setupCharacteristics();
}

void BLEManager::deviceDisconnected()
{
    qDebug() << "Device disconnected.";
}

void BLEManager::serviceDiscovered(const QBluetoothUuid &serviceUuid)
{

}

void BLEManager::setupCharacteristics()
{
    if (!bleController) {
        qDebug() << "BLE controller not available.";
        return;
    }

    bleService = bleController->createServiceObject(QBluetoothUuid(/* Service UUID */));
    if (!bleService) {
        qDebug() << "Failed to create service object.";
        return;
    }

    //leftCharacteristic = bleService->characteristic(QBluetoothUuid(/* Left Tracker Characteristic UUID */));
    //rightCharacteristic = bleService->characteristic(QBluetoothUuid(/* Right Tracker Characteristic UUID */));

    if (!leftCharacteristic || !rightCharacteristic) {
        qDebug() << "Failed to retrieve characteristics.";
        return;
    }

    connect(bleService, &QLowEnergyService::characteristicChanged,
            this, &BLEManager::characteristicChanged);

    bleService->discoverDetails();
}

void BLEManager::characteristicChanged(const QLowEnergyCharacteristic &characteristic, const QByteArray &value)
{
    if (characteristic == *leftCharacteristic) {
        qDebug() << "Left Tracker Value:" << value.toHex();
        // Process left tracker data as needed
    } else if (characteristic == *rightCharacteristic) {
        qDebug() << "Right Tracker Value:" << value.toHex();
        // Process right tracker data as needed
    }
}
