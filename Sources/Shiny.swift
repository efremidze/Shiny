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
    
    open lazy var sceneView: SceneView = {
        let sceneView = SceneView(frame: self.bounds.insetBy(dx: -500, dy: -500))
//        self.addSubview(sceneView) // testing
        self.insertSubview(sceneView, at: 0)
        return sceneView
    }()
    
    /**
     The array of UIColor objects defining the color of each gradient stop.
     */
    open var colors = [UIColor]()
    
    /**
     The array of CGFloat objects defining the location of each gradient stop as a value in the range [0,1]. The values must be monotonically increasing. If a nil array is given, the stops are assumed to spread uniformly across the [0,1] range. Defaults to nil.
     */
    open var locations: [CGFloat]?
    
    /**
     The scale factor of the gradient. Defaults to 2.
     */
    open var scale: CGFloat = 2
    
    /**
     The axis of the gradient. Defaults to vertical.
     */
    open var axis: Axis = .vertical
    
    /**
     Starts listening to motion updates.
     */
    open func startUpdates() {
        sceneView.image = GradientSnapshotter.snapshot(frame: self.bounds, colors: colors, locations: locations, scale: scale)
        Gyro.observe { [weak self] roll, pitch, yaw in
            guard let `self` = self else { return }
            
//            SCNTransaction.animationDuration = 0
            if self.axis.contains(.vertical) {
                self.sceneView.cameraNode.eulerAngles.x = Float(pitch - .pi / 2)
            } else if self.axis.contains(.horizontal) {
                self.sceneView.cameraNode.eulerAngles.y = Float(roll)
            }
//            self.sceneView.cameraNode.eulerAngles = SCNVector3(x: Float(pitch - .pi/2), y: Float(roll), z: Float(yaw)) // 360° Support
        }
    }
    
    /**
     Stops listening to motion updates.
     */
    open func stopUpdates() {
        Gyro.stopDeviceMotionUpdates()
    }
    
}
