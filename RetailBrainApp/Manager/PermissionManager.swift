//
//  PermissionManager.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 30/06/26.
//

import CoreLocation
import CoreBluetooth

class PermissionManager: NSObject, CLLocationManagerDelegate, CBCentralManagerDelegate {
    static let shared = PermissionManager()
    
    private let locationManager = CLLocationManager()
    private(set) var locationPermissionStatus: CLAuthorizationStatus = .notDetermined
    private(set) var bluetoothPermissionStatus: CBManagerAuthorization = .notDetermined
    
    private var requestCompletions: [(Bool) -> Void] = []
    private var locationCompletion: ((Bool) -> Void)?
    private var bluetoothCompletion: ((Bool) -> Void)?
    private var centralManager: CBCentralManager?
    
    // MARK: - Initialization
    
    override private init() {
        super.init()
        locationManager.delegate = self
        updatePermissionStatuses()
    }
    
    // MARK: - Permission Status
    
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
    
    // MARK: - Individual Permission Requests
    
    func requestLocationPermissionOnly(completion: @escaping (Bool) -> Void) {
        updatePermissionStatuses()
        
        if isLocationPermissionGranted {
            DispatchQueue.main.async {
                completion(true)
            }
            return
        }
        self.locationCompletion = completion
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.updatePermissionStatuses()
            if let completion = self?.locationCompletion {
                let granted = self?.isLocationPermissionGranted ?? false
                completion(granted)
                self?.locationCompletion = nil
            }
        }
    }

    func requestBluetoothPermissionOnly(completion: @escaping (Bool) -> Void) {
        updatePermissionStatuses()
        
        if isBluetoothPermissionGranted {
            DispatchQueue.main.async {
                completion(true)
            }
            return
        }
        self.bluetoothCompletion = completion
        
        centralManager = CBCentralManager(delegate: self, queue: .main)
        
        let timeoutDuration: TimeInterval = isSimulator() ? 3.0 : 2.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeoutDuration) { [weak self] in
            self?.updatePermissionStatuses()
            if let completion = self?.bluetoothCompletion {
                let granted = self?.isBluetoothPermissionGranted ?? false
                completion(granted)
                self?.bluetoothCompletion = nil
            }
            self?.centralManager = nil
        }
    }
    
    // MARK: - Batch Permission Request
    
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
    
    // MARK: - Helper Methods
    
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
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updatePermissionStatuses()
        
        if let completion = locationCompletion {
            completion(isLocationPermissionGranted)
            locationCompletion = nil
        }
        
        if !requestCompletions.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.completePermissionRequest()
            }
        }
    }
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        updatePermissionStatuses()
        
        if let completion = bluetoothCompletion {
            completion(isBluetoothPermissionGranted)
            bluetoothCompletion = nil
        }
        
        if !requestCompletions.isEmpty {
            completePermissionRequest()
        }
    }
}
