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
    
    @IBOutlet weak var holographicView: HolographicView! {
        didSet {
            holographicView.imageView.image = UIImage(named: "pattern")
            holographicView.imageView.contentMode = .scaleToFill
            holographicView.layer.cornerRadius = 6
            holographicView.layer.masksToBounds = true
        }
    }
    
}
