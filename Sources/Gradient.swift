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
        replicatorLayer.masksToBounds = true
        return replicatorLayer
    }()
    lazy var verticalLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = size
        replicatorLayer.masksToBounds = true
        return replicatorLayer
    }()
    lazy var instanceLayer: T = {
        let layer = T()
        layer.backgroundColor = UIColor.clear.cgColor
        self.insertSublayer(verticalLayer, at: 0)
        verticalLayer.addSublayer(horizontalLayer)
        horizontalLayer.addSublayer(layer)
        return layer
    }()
    var instanceSize: CGSize?
    override func layoutSublayers() {
        super.layoutSublayers()
        
        guard let instanceSize = instanceSize else { return }
        horizontalLayer.instanceCount = Int(ceil(size.width / instanceSize.width))
        horizontalLayer.instanceTransform = CATransform3DMakeTranslation(instanceSize.width, 0, 0)
        verticalLayer.instanceCount = Int(ceil(size.height / instanceSize.height))
        verticalLayer.instanceTransform = CATransform3DMakeTranslation(0, instanceSize.height, 0)
        instanceLayer.frame.size = instanceSize
    }
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

public struct GradientSnapshotter {
    typealias GradientLayerView = LayerView<ReplicatorLayer<CAGradientLayer>>
    public static func snapshot(frame: CGRect, colors: [UIColor], locations: [CGFloat]?, scale: CGFloat) -> UIImage {
        let layerView = GradientLayerView(frame: frame)
        layerView.frame.size.height = frame.height * scale
        layerView._layer.instanceSize = frame.size
        layerView._layer.instanceLayer.colors = colors.map { $0.cgColor }
        layerView._layer.instanceLayer.locations = locations as [NSNumber]?
        return UIImage(from: layerView)
    }
}

//protocol GradientLayerProtocol: class {
//    associatedtype T: CALayer
//    var layerView: LayerView<ReplicatorLayer<T>> { get set }
//    var gradientView: T { get }
//    var instanceSize: CGSize { get set }
//}
//
//extension GradientLayerProtocol {
//    var gradientView: T {
//        return layerView._layer.instanceLayer
//    }
//    var instanceSize: CGSize {
//        get { return layerView._layer.instanceSize }
//        set { layerView._layer.instanceSize = newValue }
//    }
//}
