//
//  Extensions.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/20/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import UIKit

infix operator %: MultiplicationPrecedence
func % (left: CGFloat, right: CGFloat) -> CGFloat {
    let v = left.truncatingRemainder(dividingBy: right)
    return v >= 0 ? v : v + right
}

extension UIImage {
    convenience init(from view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        self.init(cgImage:(UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }
}
