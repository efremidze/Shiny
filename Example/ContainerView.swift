//
//  ContainerView.swift
//  Example
//
//  Created by Lasha Efremidze on 12/19/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

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
