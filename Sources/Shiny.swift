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
    
    lazy var gradientLayer: RadialGradientLayer = {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.needsDisplayOnBoundsChange = true
        gradientLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
    
    /**
     The array of UIColor objects defining the color of each gradient stop.
     */
    open var colors = [UIColor]() {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
            gradientLayer.frame = self.bounds.insetBy(dx: -self.bounds.width * CGFloat(colors.count) * spread, dy: -self.bounds.height * CGFloat(colors.count) / spread)
        }
    }
    
    /**
     The array of CGFloat objects defining the location of each gradient stop as a value in the range [0,1]. The values must be monotonically increasing. If a nil array is given, the stops are assumed to spread uniformly across the [0,1] range. Defaults to nil.
     */
    open var locations: [CGFloat]? {
        get { return gradientLayer.locations }
        set { gradientLayer.locations = newValue }
    }
    
    /**
     The distance between colors on the gradient.
     */
    open var spread: CGFloat = 0.8
    
    /**
     The padding on the edges of the gradient.
     */
    open var padding: CGFloat = 0.1
    
    /**
     The sensitivity of the gyroscopic motion.
     */
    open var sensitivity: CGFloat = 0.2
    
    /**
     Starts listening to motion updates.
     */
    open func startUpdates() {
        Gyro.observe { [weak self] vector in
            guard let `self` = self else { return }
            self.gradientLayer.anchorPoint.x = (vector.dx * self.sensitivity).center().add(self.padding)
            self.gradientLayer.anchorPoint.y = (vector.dy * self.sensitivity).center().add(self.padding)
        }
    }
    
    /**
     Stops listening to motion updates.
     */
    open func stopUpdates() {
        Gyro.stopDeviceMotionUpdates()
    }
    
}
