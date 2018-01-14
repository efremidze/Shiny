//
//  Shiny.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit
import CoreMotion

//@IBDesignable
open class ShinyView: UIView {
    
    lazy var horizontalLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = size
        replicatorLayer.instanceCount = Int(ceil(size.width / itemSize.width))
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(itemSize.width, 0, 0)
        return replicatorLayer
    }()
    
    lazy var verticalLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = itemSize
//        replicatorLayer.position = CGPoint(x: -itemSize.width / 2, y: -itemSize.height / 2)
//        replicatorLayer.frame = self.frame.insetBy(dx: -size.width / 2, dy: -size.height / 2)
        replicatorLayer.instanceCount = Int(ceil(size.height / itemSize.height))
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(0, itemSize.height, 0)
        return replicatorLayer
    }()
    
    lazy var gradientLayer: RadialGradientLayer = {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.frame.size = itemSize
        gradientLayer.needsDisplayOnBoundsChange = true
        gradientLayer.backgroundColor = UIColor.clear.cgColor
//        self.layer.insertSublayer(verticalLayer, at: 0) // TEMP
        self.layer.addSublayer(verticalLayer)
        verticalLayer.addSublayer(horizontalLayer)
        horizontalLayer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    var size: CGSize {
        return CGSize(width: itemSize.width * 4, height: itemSize.height * 4)
    }
    
    var itemSize: CGSize {
        let dimension = min(self.frame.width, self.frame.height)
        return CGSize(width: dimension, height: dimension)
    }
    
    // width / 3 +- 0.5
    
    /**
     The array of UIColor objects defining the color of each gradient stop.
     */
    open var colors = [UIColor]() {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
//            replicatorLayer.frame = self.bounds.insetBy(dx: -self.bounds.width * CGFloat(colors.count) * spread, dy: -self.bounds.height * CGFloat(colors.count) * spread)
        }
    }
    
    /**
     The array of CGFloat objects defining the location of each gradient stop as a value in the range [0,1]. The values must be monotonically increasing. If a nil array is given, the stops are assumed to spread uniformly across the [0,1] range. Defaults to nil.
     */
    open var locations: [CGFloat]? {
        get { return gradientLayer.locations }
        set { gradientLayer.locations = newValue }
    }
    
    open var rollOffset: CGFloat = 0
    open var pitchOffset: CGFloat = 0
    
    /**
     Starts listening to motion updates.
     */
    open func startUpdates() {
        self.verticalLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        Gyro.observe { [weak self] roll, pitch, yaw in
            guard let `self` = self else { return }
            self.verticalLayer.anchorPoint.x = ((180 + roll + self.rollOffset) % 360) / 360
            self.verticalLayer.anchorPoint.y = ((180 + pitch + self.pitchOffset) % 360) / 360
        }
    }
    
    /**
     Stops listening to motion updates.
     */
    open func stopUpdates() {
        Gyro.stopDeviceMotionUpdates()
    }
    
}
