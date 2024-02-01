// blescanner.cpp
#include "blescanner.h"

BleScanner::BleScanner(QObject *parent) : QObject(parent)
{
    discoveryAgent = new QBluetoothDeviceDiscoveryAgent(this);

    // Connect the signal from the discovery agent to our handler
    connect(discoveryAgent, &QBluetoothDeviceDiscoveryAgent::deviceDiscovered,
            this, &BleScanner::deviceDiscoveredHandler);
}

BleScanner::~BleScanner()
{
    delete discoveryAgent;
}

void BleScanner::startScan()
{
    // Start scanning for devices
    discoveryAgent->start();
}

void BleScanner::stopScan()
{
    // Stop scanning for devices
    discoveryAgent->stop();
}

void BleScanner::deviceDiscoveredHandler(const QBluetoothDeviceInfo &deviceInfo)
{
    // Emit signal with discovered device information
    discoveredDevices << deviceInfo.name() + " (" + deviceInfo.address().toString() + ")";
    emit devicesListUpdated(discoveredDevices);
}
