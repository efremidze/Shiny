//
//  Extensions.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/20/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

infix operator %: MultiplicationPrecedence
func % <T: FloatingPoint>(left: T, right: T) -> T {
    let v = left.truncatingRemainder(dividingBy: right)
    return v >= 0 ? v : v + right
}

extension UIImage {
    convenience init(from view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        self.init(cgImage:(UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
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

public extension OperationQueue {
    static let background = OperationQueue()
}

//extension UIView {
//    var snapshot: UIImage {
//        return UIImage(from: self)
//    }
//}
