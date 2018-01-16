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
    
    let cameraNode = SCNNode()
    
    lazy var sphere: SCNSphere = {
        let sceneView = SCNView(frame: self.bounds.insetBy(dx: -300, dy: -300))
        self.addSubview(sceneView)
        
        // Set the scene
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        
        // Create node, containing a sphere, using the panoramic image as a texture
        let sphere = SCNSphere(radius: 20)
        sphere.firstMaterial!.isDoubleSided = true
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(sphereNode)
        
        // Camera, ...
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(cameraNode)
        
        return sphere
    }()
    
    open var colors = [UIColor]() {
        didSet {
//            view.gradientLayer.colors = colors.map { $0.cgColor }
        }
    }
    
    open var locations: [CGFloat]?
    
    /**
     Starts listening to motion updates.
     */
    open func startUpdates() {
        let view = LayerView<ReplicatorLayer<CAGradientLayer>>(frame: self.bounds)
        view.frame.size.height = 200 * 2
        view._layer.instanceSize.height = 200
        view._layer.instanceLayer.colors = colors.map { $0.cgColor }
        view._layer.instanceLayer.locations = locations as [NSNumber]?
        let image = UIImage(from: view)
        sphere.firstMaterial!.diffuse.contents = image
        
        Gyro.observe { [weak self] roll, pitch, yaw in
            guard let `self` = self else { return }
            
            SCNTransaction.animationDuration = 0
            self.cameraNode.eulerAngles.x = Float(pitch - .pi/2)
//            self.cameraNode.eulerAngles = SCNVector3(x: Float(pitch - .pi/2), y: Float(roll), z: Float(yaw)) // 360
        }
    }
    
    /**
     Stops listening to motion updates.
     */
    open func stopUpdates() {
        Gyro.stopDeviceMotionUpdates()
    }
    
}
