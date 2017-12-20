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
            holographicView.colors = UIColor.all.map { $0.withAlphaComponent(0.5) }
            holographicView.layer.cornerRadius = 20
            holographicView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
            imageView.tintColor = .background
        }
    }
    @IBOutlet weak var textLabel: UILabel! {
        didSet {
            textLabel.attributedText = {
                let string = NSMutableAttributedString(string: "Pay", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .medium)])
                string.append(NSAttributedString(string: " ", attributes: [.font: UIFont.systemFont(ofSize: 10)]))
                string.append(NSAttributedString(string: "Cash", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .light)]))
                return string
            }()
        }
    }
}
