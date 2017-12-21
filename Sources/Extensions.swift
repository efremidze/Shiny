//
//  Extensions.swift
//  Shiny
//
//  Created by Lasha Efremidze on 12/20/17.
//  Copyright © 2017 Lasha Efremidze. All rights reserved.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension CGFloat {
    func center() -> CGFloat {
        return 0.5 - (self / 0.5)
    }
    func add(_ padding: CGFloat) -> CGFloat {
        return clamped(to: padding...(1 - padding))
    }
}
