//
//  Holographic.swift
//  Holographic
//
//  Created by Lasha Efremidze on 12/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit
import CoreMotion

//@IBDesignable
open class HolographicView: UIView {
    
    private lazy var gradientLayer: RadialGradientLayer = {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.needsDisplayOnBoundsChange = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }()
    
    open var colors = [UIColor]() {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
            gradientLayer.frame = self.bounds.insetBy(dx: -self.bounds.width * CGFloat(colors.count), dy: -self.bounds.height * CGFloat(colors.count))
        }
    }
    
    var targetValue: CGVector = .zero {
        didSet {
            func getPosition(_ position: CGFloat) -> CGFloat {
                let multiplier: CGFloat = 0.25
                let offset: CGFloat = 0.03
                return CGFloat(max(offset, min(0.5 - (position * multiplier / 0.5), 1 - offset)))
            }
            
            self.gradientLayer.anchorPoint.x = getPosition(targetValue.dx)
            self.gradientLayer.anchorPoint.y = getPosition(targetValue.dy)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard Gyro.isDeviceMotionAvailable else { return }
        Gyro.deviceMotionUpdateInterval = 0.1
        Gyro.observe { [weak self] vector in
            self?.targetValue = vector
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

let Gyro = GyroManager.shared

class GyroManager: CMMotionManager {
    static let shared = GyroManager()
    private let queue = OperationQueue()
    func observe(_ observer: @escaping (_ gyro: CGVector) -> Void) {
        startDeviceMotionUpdates(to: queue) { data, error in
            guard let data = data else { return }
            
            DispatchQueue.main.sync {
                observer(CGVector(dx: CGFloat(data.gravity.x), dy: CGFloat(data.gravity.y)))
            }
        }
    }
}
