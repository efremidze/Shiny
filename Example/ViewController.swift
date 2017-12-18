//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 12/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit
import Holographic

class ViewController: UIViewController {
    @IBOutlet weak var containerView: ContainerView! {
        didSet {
            containerView.layer.shadowOpacity = 0.6
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOffset = .zero
            containerView.layer.shadowRadius = 14
            containerView.layer.cornerRadius = 20
            
            let group = UIMotionEffectGroup()
            group.motionEffects = [
                UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis, span: 20),
                UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis, span: 20)
            ]
            containerView.addMotionEffect(group)
        }
    }
    @IBOutlet weak var holographicView: HolographicView! {
        didSet {
            holographicView.colors = UIColor.all
            holographicView.layer.cornerRadius = 20
            holographicView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = #imageLiteral(resourceName: "pattern")
            imageView.contentMode = .scaleToFill
        }
    }
}

// MARK: Effects

class ContainerView: UIView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate(didEnter: true)
    }
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let locations = [touch.previousLocation(in: self), touch.location(in: self)].map { self.bounds.contains($0) }
        let isEntering = !locations[0] && locations[1]
        let isExiting = locations[0] && !locations[1]
        if isEntering {
            animate(didEnter: true)
        } else if isExiting {
            animate(didEnter: false)
        }
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate(didEnter: false)
    }
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate(didEnter: false)
    }
    func animate(didEnter: Bool) {
        if didEnter {
            UIView.animate(withDuration: 0.2) { self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) }
        } else {
            UIView.animate(withDuration: 0.2) { self.transform = .identity }
        }
    }
}

extension UIInterpolatingMotionEffect {
    convenience init(keyPath: String, type: UIInterpolatingMotionEffectType, span: Int) {
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
    static let all: [UIColor] = [red, orange, yellow, green, tealBlue, blue, purple, pink]
}
