//
//  Holographic.swift
//  Holographic
//
//  Created by Lasha Efremidze on 12/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit
import CoreMotion

@IBDesignable
open class HolographicView: UIView {
    
    private lazy var gradientLayer: RadialGradientLayer = {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.needsDisplayOnBoundsChange = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
    
    private let motionManager = CMMotionManager()
    
    open var colors = [UIColor]() {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
            gradientLayer.frame = self.bounds.insetBy(dx: -self.bounds.width * CGFloat(colors.count), dy: -self.bounds.height * CGFloat(colors.count))
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { [weak self] data, error in
            guard let `self` = self, let data = data else { return }
            
            func getPosition(_ position: Double) -> CGFloat {
                let multiplier: Double = 0.25
                let offset: Double = 0.03
                return CGFloat(max(offset, min(0.5 - (position * multiplier / 0.5), 1 - offset)))
            }
            
            self.gradientLayer.anchorPoint.x = getPosition(data.gravity.x)
            self.gradientLayer.anchorPoint.y = getPosition(data.gravity.y)
        }
    }
    
}

class RadialGradientLayer: CALayer {
    var colors = [CGColor]()
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        guard let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: nil) else { return }
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: .drawsBeforeStartLocation)
    }
}

//class RadialGradientView: UIView {
//    override class var layerClass: AnyClass {
//        return RadialGradientLayer.self
//    }
//}

extension CALayer {
    var radius: CGFloat {
        return sqrt(pow(bounds.width / 2, 2) + pow(bounds.height / 2, 2))
    }
}
