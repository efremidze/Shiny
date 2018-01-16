//
//  Gyro.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/20/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import CoreMotion

let Gyro = GyroManager.shared

class GyroManager: CMMotionManager {
    static let shared = GyroManager()
    private let queue = OperationQueue()
    func observe(_ observer: @escaping (_ roll: Double, _ pitch: Double, _ yaw: Double) -> Void) {
        guard isDeviceMotionAvailable else { return }
        deviceMotionUpdateInterval = 1 / 60
        startDeviceMotionUpdates(to: queue) { data, error in
            guard let data = data else { return }
            DispatchQueue.main.sync {
                observer(data.attitude.roll, data.attitude.pitch, data.attitude.yaw)
            }
        }
    }
}
