//
//  Gradient.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/20/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

class ReplicatorLayer<T: CALayer>: CALayer {
    
    lazy var horizontalLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = size
        replicatorLayer.instanceCount = Int(ceil(size.width / instanceSize.width))
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(instanceSize.width, 0, 0)
        return replicatorLayer
    }()
    
    lazy var verticalLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = size
        replicatorLayer.instanceCount = Int(ceil(size.height / instanceSize.height))
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(0, instanceSize.height, 0)
        return replicatorLayer
    }()
    
    lazy var instanceLayer: T = {
        let layer = T()
        layer.frame.size = instanceSize
        self.insertSublayer(verticalLayer, at: 0)
        verticalLayer.addSublayer(horizontalLayer)
        horizontalLayer.addSublayer(layer)
        return layer
    }()
    
    lazy var instanceSize: CGSize = size
    
}

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

class LayerView<T: CALayer>: UIView {
    override class var layerClass: AnyClass {
        return T.self
    }
    var _layer: T {
        return layer as! T
    }
}

extension CALayer {
    var radius: CGFloat {
        return sqrt(pow(bounds.width / 2, 2) + pow(bounds.height / 2, 2))
    }
    var size: CGSize {
        return frame.size
    }
}
