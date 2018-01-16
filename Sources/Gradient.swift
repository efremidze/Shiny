//
//  Gradient.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/20/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

class RadialGradientLayer: CALayer {
    var colors = [CGColor]() { didSet { setNeedsDisplay() } }
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

class ReplicatorLayer: CALayer {
    
    lazy var horizontalLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = size
        replicatorLayer.instanceCount = Int(ceil(size.width / itemSize.width))
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(itemSize.width, 0, 0)
        return replicatorLayer
    }()
    
    lazy var verticalLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = size
        replicatorLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        //        replicatorLayer.position = CGPoint(x: itemSize.width / 2, y: itemSize.height / 2)
        //        replicatorLayer.frame = self.frame.insetBy(dx: -size.width / 2, dy: -size.height / 2)
        replicatorLayer.instanceCount = Int(ceil(size.height / itemSize.height))
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(0, itemSize.height, 0)
        return replicatorLayer
    }()
    
    lazy var gradientLayer: RadialGradientLayer = {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.frame.size = itemSize
        //        gradientLayer.needsDisplayOnBoundsChange = true
        gradientLayer.backgroundColor = UIColor.clear.cgColor
        //        self.layer.insertSublayer(verticalLayer, at: 0) // TEMP
        self.addSublayer(verticalLayer)
        verticalLayer.addSublayer(horizontalLayer)
        horizontalLayer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    var size: CGSize {
        return CGSize(width: itemSize.width * 4, height: itemSize.height * 4)
    }
    
    var itemSize: CGSize {
        let dimension = min(self.frame.width, self.frame.height)
        return CGSize(width: dimension, height: dimension)
    }
    
}

class ReplicatorLayerView: UIView {
    override class var layerClass: AnyClass {
        return ReplicatorLayer.self
    }
    var _layer: ReplicatorLayer {
        return layer as! ReplicatorLayer
    }
}
