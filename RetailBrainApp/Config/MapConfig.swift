//
//  MapConfig.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 23/06/26.
//

import Foundation
import RetailBrainSDK

struct MapConfig {
    // Multi-floor map configuration
    static let multiFloorApiKey = "5eab30aa91b055001a68e996"
    static let multiFloorApiSecret = "RJyRXKcryCMy4erZqqCbuB1NbR66QTGNXVE0x3Pg6oCIlUR1"
    static let multiFloorMapId = "mappedin-demo-mall"

    // Single-floor map configuration
    static let singleFloorApiKey = "mik_yeBk0Vf0nNJtpesfu560e07e5"
    static let singleFloorApiSecret = "mis_2g9ST8ZcSFb5R9fPnsvYhrX3RyRwPtDGbMGweCYKEq385431022"
    static let singleFloorMapId = "6679882a8298d5000b85ee89"
}

enum MapNavigationMode: String, CaseIterable {
    case singleFloor
    case multiFloor

    var title: String {
        switch self {
        case .singleFloor:
            return "Single Floor"
        case .multiFloor:
            return "Multi Floor"
        }
    }

    var mapId: String {
        switch self {
        case .singleFloor:
            return MapConfig.singleFloorMapId
        case .multiFloor:
            return MapConfig.multiFloorMapId
        }
    }

    var apiKey: String {
        switch self {
        case .singleFloor:
            return MapConfig.singleFloorApiKey
        case .multiFloor:
            return MapConfig.multiFloorApiKey
        }
    }

    var apiSecret: String {
        switch self {
        case .singleFloor:
            return MapConfig.singleFloorApiSecret
        case .multiFloor:
            return MapConfig.multiFloorApiSecret
        }
    }

    var sdkConfig: RetailBrainConfig {
        RetailBrainConfig(apiKey: apiKey, apiSecret: apiSecret, mapId: mapId)
    }

    var isMultiFloorEnabled: Bool {
        self == .multiFloor
    }
}
