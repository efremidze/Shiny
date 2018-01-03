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
    func observe(_ observer: @escaping (CGFloat, CGFloat) -> Void) {
        guard isDeviceMotionAvailable else { return }
        deviceMotionUpdateInterval = 5 / 60
        startDeviceMotionUpdates(to: queue) { data, error in
            guard let data = data else { return }
            DispatchQueue.main.sync {
                observer(CGFloat(data.attitude.roll.degrees), CGFloat(data.attitude.pitch.degrees))
            }
        }
    }
}

extension FloatingPoint {
    var degrees: Self { return self * 180 / .pi }
}
