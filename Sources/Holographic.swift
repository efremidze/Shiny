//
//  Holographic.swift
//  Holographic
//
//  Created by Lasha Efremidze on 12/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import CoreMotion

open class HolographicView: UIView {
    private let motionManager = CMMotionManager()
    open let imageView = UIImageView()
    private let gradient = CAGradientLayer()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        self.backgroundColor = .red
        
        gradient.frame = self.bounds
        gradient.colors = [
            UIColor.red.cgColor,
            UIColor.blue.cgColor
        ]
//        gradient.speed = 0
//        gradient.timeOffset = 0
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        self.layer.addSublayer(gradient)
        
        imageView.frame = self.bounds
        self.addSubview(imageView)
        
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { [unowned self] data, error in
            guard let data = data else { return }
            
            let gradient = self.gradient
            
            print(data.gravity)
            
//            gradient.timeOffset = data.gravity.x / 100
            
            gradient.startPoint.x = CGFloat(max(0, min(0.5 - (data.gravity.x / 0.5), 1)))
            gradient.startPoint.y = CGFloat(max(0, min(0.5 + (data.gravity.y / 0.5), 1)))
            gradient.endPoint.x = CGFloat(max(0, min(0.5 + (data.gravity.x / 0.5), 1)))
            gradient.endPoint.y = CGFloat(max(0, min(0.5 - (data.gravity.y / 0.5), 1)))

            print(gradient.startPoint)
            print(gradient.endPoint)

//            if data.gravity.x > 0 {
//                gradient.startPoint.x = 0
//                gradient.startPoint.y = 0.5
//                gradient.endPoint.x = 1
//                gradient.endPoint.y = 0.5
//            }
//            if data.gravity.y > 0 {
//                gradient.startPoint.x = 0.5
//                gradient.startPoint.y = 1
//                gradient.endPoint.x = 0.5
//                gradient.endPoint.y = 0
//            }
        }
    }
}
