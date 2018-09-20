//
//  Scene.swift
//  Shiny
//
//  Created by Lasha Efremidze on 1/17/18.
//  Copyright © 2018 Lasha Efremidze. All rights reserved.
//

import Foundation
import SceneKit

open class SceneView: SCNView {
    open lazy var sphere: SCNSphere = {
        self.scene = SCNScene()
        
        let sphere = SCNSphere(radius: 5) // default
        sphere.firstMaterial!.isDoubleSided = true
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3Make(0, 0, 0)
        self.scene?.rootNode.addChildNode(sphereNode)
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 0, 0)
        self.scene?.rootNode.addChildNode(cameraNode)
        
        return sphere
    }()
    public let cameraNode = SCNNode()
    open var image: UIImage? {
        get { return sphere.firstMaterial!.diffuse.contents as? UIImage }
        set { sphere.firstMaterial!.diffuse.contents = newValue }
    }
}
