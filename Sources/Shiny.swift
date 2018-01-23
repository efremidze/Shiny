//
//  Shiny.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit
import CoreMotion
import SceneKit

open class ShinyView: UIView {
    
    lazy var sceneView: SceneView = {
        let sceneView = SceneView(frame: self.bounds.insetBy(dx: -500, dy: -500))
//        self.addSubview(sceneView) // testing
        self.insertSubview(sceneView, at: 0)
        return sceneView
    }()
    
    open var colors = [UIColor]()
    open var locations: [CGFloat]?
    open var scale: CGFloat = 2
    
    /**
     Starts listening to motion updates.
     */
    open func startUpdates() {
        sceneView.image = GradientSnapshotter.snapshot(frame: self.bounds, colors: colors, locations: locations, scale: scale)
        Gyro.observe { [weak self] roll, pitch, yaw in
            guard let `self` = self else { return }
            
//            SCNTransaction.animationDuration = 0
            self.sceneView.cameraNode.eulerAngles.x = Float(pitch - .pi/2)
//            self.sceneView.cameraNode.eulerAngles = SCNVector3(x: Float(pitch - .pi/2), y: Float(roll), z: Float(yaw)) // 360
        }
    }
    
    /**
     Stops listening to motion updates.
     */
    open func stopUpdates() {
        Gyro.stopDeviceMotionUpdates()
    }
    
}
