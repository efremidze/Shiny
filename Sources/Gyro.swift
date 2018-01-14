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
    func observe(_ observer: @escaping (_ roll: Float, _ pitch: Float, _ yaw: Float) -> Void) {
        guard isDeviceMotionAvailable else { return }
        deviceMotionUpdateInterval = 0.1
        startDeviceMotionUpdates(to: queue) { data, error in
            guard let data = data else { return }
            let roll = Float(data.attitude.roll)
            let pitch = Float(data.attitude.pitch)
            let yaw = Float(data.attitude.yaw)
            DispatchQueue.main.sync {
                observer(roll, pitch, yaw)
            }
        }
    }
}
