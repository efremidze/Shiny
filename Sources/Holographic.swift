//
//  Holographic.swift
//  Holographic
//
//  Created by Lasha Efremidze on 12/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation
import CoreMotion

open class HolographicView: UIView {
    public let contentView = UIView()
    private let motionManager = CMMotionManager()
    open let imageView = UIImageView()
//    private let gradient = CAGradientLayer()
    private let gradient = RadialGradientLayer()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        contentView.frame = self.bounds
        contentView.layer.masksToBounds = true
        self.addSubview(contentView)
        
        gradient.needsDisplayOnBoundsChange = true
        gradient.frame = self.bounds.insetBy(dx: -self.bounds.width * CGFloat(UIColor.all.count), dy: -self.bounds.height * CGFloat(UIColor.all.count))
        print(gradient.frame)
        gradient.colors = UIColor.all.map { $0.cgColor } + UIColor.all.reversed().map { $0.cgColor }
        contentView.layer.addSublayer(gradient)
        
        imageView.frame = self.bounds
        contentView.addSubview(imageView)
        
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { [weak self] data, error in
            guard let `self` = self, let data = data else { return }
            
            func getPosition(_ position: Double) -> CGFloat {
                let multiplier: Double = 0.5
                let offset: Double = 0.03
                print(0.5 + (position * multiplier / 0.5))
                return CGFloat(max(offset, min(0.5 - (position * multiplier / 0.5), 1 - offset)))
            }
            
            self.gradient.anchorPoint.x = getPosition(data.gravity.x)
            self.gradient.anchorPoint.y = getPosition(data.gravity.y)
        }
    }
}

class RadialGradientLayer: CALayer {
    var colors = [CGColor]()
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let locations: [CGFloat] = [0.0, 1.0]
//        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else { return  }
        guard let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: nil) else { return  }
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: radius, options: .drawsBeforeStartLocation)
    }
}

extension CALayer {
    var radius: CGFloat {
        return sqrt(pow(bounds.width / 2, 2) + pow(bounds.height / 2, 2))
    }
//    var center: CGPoint {
//        get { return CGPoint(x: position.x + (bounds.width / 2), y: position.y + (bounds.height / 2)) }
//        set { position = CGPoint(x: newValue.x - (bounds.width / 2), y: newValue.y - (bounds.height / 2)) }
//    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    class var red: UIColor { return UIColor(red: 255, green: 59, blue: 48) }
    class var orange: UIColor { return UIColor(red: 255, green: 149, blue: 0) }
    class var yellow: UIColor { return UIColor(red: 255, green: 204, blue: 0) }
    class var green: UIColor { return UIColor(red: 76, green: 217, blue: 100) }
    class var tealBlue: UIColor { return UIColor(red: 90, green: 200, blue: 250) }
    class var blue: UIColor { return UIColor(red: 0, green: 122, blue: 255) }
    class var purple: UIColor { return UIColor(red: 88, green: 86, blue: 214) }
    class var pink: UIColor { return UIColor(red: 255, green: 45, blue: 85) }
    class var all: [UIColor] { return [red, orange, yellow, green, tealBlue, blue, purple, pink] }
}
