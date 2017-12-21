//
//  Gradient.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/20/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

class RadialGradientLayer: CALayer {
    var colors = [CGColor]()
    var locations: [CGFloat]?
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        guard let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: locations) else { return }
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
