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
    let queue = OperationQueue()
    func observe(_ observer: @escaping (_ roll: Double, _ pitch: Double, _ yaw: Double) -> Void) {
        guard isDeviceMotionAvailable else { return }
        deviceMotionUpdateInterval = 1 / 60
        startDeviceMotionUpdates(to: queue) { data, error in
            guard let data = data else { return }
            var pitch = data.attitude.pitch
            if data.gravity.z > 0 {
                if pitch > 0 {
                    pitch = .pi - pitch
                } else {
                    pitch = -(.pi + pitch)
                }
            }
            DispatchQueue.main.sync {
                observer(data.attitude.roll, pitch, data.attitude.yaw)
            }
        }
    }
}

struct Axis: OptionSet {
    let rawValue: Int
    
    static let vertical = Axis(rawValue: 1 << 0)
    static let horizontal = Axis(rawValue: 1 << 1)
    
    static let all: Axis = [.vertical, .horizontal]
}
