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
    
    lazy var replicatorLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
//        replicatorLayer.frame.origin.x = -itemSize.width
//        replicatorLayer.frame.origin.y = -itemSize.height
        replicatorLayer.frame.size = size
        replicatorLayer.masksToBounds = true
        replicatorLayer.instanceCount = Int(ceil(size.width / itemSize.width))
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(
            itemSize.width, 0, 0
        )
        self.layer.addSublayer(replicatorLayer)
        
        return replicatorLayer
    }()
    
    lazy var replicatorLayer2: CAReplicatorLayer = {
        let replicatorLayer2 = CAReplicatorLayer()
        replicatorLayer2.frame.origin.x = -itemSize.width
        replicatorLayer2.frame.origin.y = -itemSize.height
        replicatorLayer2.frame.size = size
        replicatorLayer2.masksToBounds = true
        replicatorLayer2.instanceCount = Int(ceil(size.height / itemSize.height))
        replicatorLayer2.instanceTransform = CATransform3DMakeTranslation(
            0, itemSize.height, 0
        )
        self.layer.addSublayer(replicatorLayer2)
        
        replicatorLayer2.addSublayer(replicatorLayer)
        
        return replicatorLayer2
    }()
    
    lazy var gradientLayer: RadialGradientLayer = {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.frame.size = itemSize
//        gradientLayer.needsDisplayOnBoundsChange = true
        gradientLayer.backgroundColor = UIColor.clear.cgColor
//        self.layer.insertSublayer(gradientLayer, at: 0)
        replicatorLayer.addSublayer(gradientLayer)
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
        self.replicatorLayer2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        Gyro.observe { [weak self] roll, pitch in
            guard let `self` = self else { return }
            self.replicatorLayer2.anchorPoint.x = ((180 + roll + self.rollOffset) % 360) / 360
            self.replicatorLayer2.anchorPoint.y = ((90 + pitch + self.pitchOffset) % 180) / 180
        }
    }
    
    /**
     Stops listening to motion updates.
     */
    open func stopUpdates() {
        Gyro.stopDeviceMotionUpdates()
    }
    
}
