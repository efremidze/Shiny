//
//  Extensions.swift
//  Example
//
//  Created by Lasha Efremidze on 12/19/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

extension UIView {
    func addParallax() {
        let group = UIMotionEffectGroup()
        group.motionEffects = [
            UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis, span: 20),
            UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis, span: 20)
        ]
        addMotionEffect(group)
    }
}

extension UIInterpolatingMotionEffect {
    convenience init(keyPath: String, type: UIInterpolatingMotionEffect.EffectType, span: Int) {
        self.init(keyPath: keyPath, type: type)
        self.minimumRelativeValue = -span
        self.maximumRelativeValue = span
    }
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
    class var background: UIColor { return UIColor(red: 17, green: 17, blue: 17) }
    class var gray: UIColor { return UIColor(red: 34, green: 34, blue: 34) }
}
