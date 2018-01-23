//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 12/12/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit
import Shiny

class ViewController: UIViewController {
    @IBOutlet weak var containerView: ContainerView! {
        didSet {
            containerView.layer.shadowOpacity = 0.6
            containerView.layer.shadowColor = UIColor.gray.cgColor
            containerView.layer.shadowOffset = .zero
            containerView.layer.shadowRadius = 14
            containerView.layer.cornerRadius = 20
            containerView.addParallax()
        }
    }
    @IBOutlet weak var shinyView: ShinyView! {
        didSet {
            shinyView.layer.cornerRadius = 20
            shinyView.layer.masksToBounds = true
            shinyView.colors = [UIColor.gray, UIColor.gray, UIColor.red, UIColor.orange, UIColor.green, UIColor.blue, UIColor.purple, UIColor.pink, UIColor.gray, UIColor.gray].map { $0.withAlphaComponent(0.9) }
            shinyView.startUpdates()
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
