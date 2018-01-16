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
        let sceneView = SCNView(frame: self.bounds)
        self.addSubview(sceneView)
        
        // Set the scene
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        
        // Create node, containing a sphere, using the panoramic image as a texture
        let sphere = SCNSphere(radius: 40.0)
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
    
    /**
     Starts listening to motion updates.
     */
    open func startUpdates() {
        let view = ReplicatorLayerView(frame: self.bounds)
        view._layer.gradientLayer.colors = colors.map { $0.cgColor }
        let image = UIImage(from: view)
        sphere.firstMaterial!.diffuse.contents = image
        
        // 6 gradients
        // (1, 0, 0), (0, 1, 0), (0, 0, 1)
        // (-1, 0, 0), (0, -1, 0), (0, 0, -1)

        Gyro.observe { [weak self] roll, pitch, yaw in
            guard let `self` = self else { return }
            self.cameraNode.eulerAngles = SCNVector3(x: Float(pitch - .pi/2), y: 0, z: 0)
        }
    }
    
    /**
     Stops listening to motion updates.
     */
    open func stopUpdates() {
        Gyro.stopDeviceMotionUpdates()
    }
    
}
