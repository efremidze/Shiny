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
    func observe(_ observer: @escaping (_ gyro: CGVector) -> Void) {
        guard isDeviceMotionAvailable else { return }
        deviceMotionUpdateInterval = 0.1
        startDeviceMotionUpdates(to: queue) { data, error in
            guard let data = data else { return }
            DispatchQueue.main.sync {
                observer(CGVector(dx: CGFloat(data.gravity.x), dy: CGFloat(data.gravity.y)))
            }
        }
    }
}
