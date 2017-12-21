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
    
    open var colors = [UIColor]() {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
            gradientLayer.frame = self.bounds.insetBy(dx: -self.bounds.width * CGFloat(colors.count) * spread, dy: -self.bounds.height * CGFloat(colors.count) / spread)
        }
    }
    
    open var locations: [CGFloat]? {
        get { return gradientLayer.locations }
        set { gradientLayer.locations = newValue }
    }
    
    open var spread: CGFloat = 0.8
    open var intensity: CGFloat = 0.2
    open var padding: CGFloat = 0.1
    
    open func startUpdates() {
        Gyro.observe { [weak self] vector in
            guard let `self` = self else { return }
            self.gradientLayer.anchorPoint.x = (vector.dx * self.intensity).center().add(self.padding)
            self.gradientLayer.anchorPoint.y = (vector.dy * self.intensity).center().add(self.padding)
        }
    }
    
    open func stopUpdates() {
        Gyro.stopDeviceMotionUpdates()
    }
    
}
