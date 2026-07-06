//
//  PermissionManager.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 30/06/26.
//

import CoreLocation
import CoreBluetooth

class PermissionManager: NSObject, CLLocationManagerDelegate, CBCentralManagerDelegate {

    private let locationManager = CLLocationManager()
    private(set) var locationPermissionStatus: CLAuthorizationStatus = .notDetermined
    private(set) var bluetoothPermissionStatus: CBManagerAuthorization = .notDetermined

    private var requestCompletions: [(Bool) -> Void] = []
    private var locationCompletion: ((Bool) -> Void)?
    private var bluetoothCompletion: ((Bool) -> Void)?
    private var centralManager: CBCentralManager?

    override init() {
        super.init()
        locationManager.delegate = self
        updatePermissionStatuses()
    }

    func updatePermissionStatuses() {
        locationPermissionStatus = locationManager.authorizationStatus
        bluetoothPermissionStatus = CBManager.authorization
    }

    var areAllPermissionsGranted: Bool {
        let locationGranted = locationPermissionStatus == .authorizedAlways || locationPermissionStatus == .authorizedWhenInUse
        let bluetoothGranted = bluetoothPermissionStatus == .allowedAlways
        return locationGranted && bluetoothGranted
    }

    var isLocationPermissionGranted: Bool {
        locationPermissionStatus == .authorizedAlways || locationPermissionStatus == .authorizedWhenInUse
    }

    var isBluetoothPermissionGranted: Bool {
        bluetoothPermissionStatus == .allowedAlways
    }

    // MARK: Individual Permission Requests
    func requestLocationPermissionOnly(completion: @escaping (Bool) -> Void) {
        updatePermissionStatuses()

        if isLocationPermissionGranted {
            DispatchQueue.main.async {
                completion(true)
            }
            return
        }
        if locationPermissionStatus == .denied || locationPermissionStatus == .restricted {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        self.locationCompletion = completion
        locationManager.requestWhenInUseAuthorization()
    }

    func requestBluetoothPermissionOnly(completion: @escaping (Bool) -> Void) {
        updatePermissionStatuses()

        if isBluetoothPermissionGranted {
            DispatchQueue.main.async {
                completion(true)
            }
            return
        }
        if bluetoothPermissionStatus == .denied || bluetoothPermissionStatus == .restricted {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        self.bluetoothCompletion = completion
        centralManager = CBCentralManager(delegate: self, queue: .main)
        let timeoutDuration: TimeInterval = isSimulator() ? 5.0 : 10.0
        DispatchQueue.main.asyncAfter(deadline: .now() + timeoutDuration) { [weak self] in
            guard let self, let completion = self.bluetoothCompletion else { return }
            self.updatePermissionStatuses()
            completion(self.isBluetoothPermissionGranted)
            self.bluetoothCompletion = nil
            self.centralManager = nil
        }
    }

    // MARK: Batch Permission Request
    func requestPermissions(completion: @escaping (Bool) -> Void) {
        updatePermissionStatuses()

        if areAllPermissionsGranted {
            DispatchQueue.main.async {
                completion(true)
            }
            return
        }

        requestCompletions.append(completion)

        if !isLocationPermissionGranted {
            locationManager.requestWhenInUseAuthorization()
        }

        if !isBluetoothPermissionGranted {
            centralManager = CBCentralManager(delegate: self, queue: .main)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.completePermissionRequest()
        }
    }

    private func completePermissionRequest() {
        updatePermissionStatuses()
        let allGranted = areAllPermissionsGranted

        let completions = requestCompletions
        requestCompletions.removeAll()

        for completion in completions {
            completion(allGranted)
        }

        centralManager = nil
    }

    private func isSimulator() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    // MARK: CLLocationManagerDelegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updatePermissionStatuses()

        guard locationPermissionStatus != .notDetermined else { return }

        if let completion = locationCompletion {
            locationCompletion = nil
            completion(isLocationPermissionGranted)
        }

        if !requestCompletions.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.completePermissionRequest()
            }
        }
    }

    // MARK: CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        updatePermissionStatuses()

        guard bluetoothPermissionStatus != .notDetermined else { return }

        if let completion = bluetoothCompletion {
            bluetoothCompletion = nil
            centralManager = nil
            completion(isBluetoothPermissionGranted)
        }

        if !requestCompletions.isEmpty {
            completePermissionRequest()
        }
    }
}
