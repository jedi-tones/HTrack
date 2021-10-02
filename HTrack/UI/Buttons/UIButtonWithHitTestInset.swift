//
//  UIButtonWithHitTestInset.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

class UIButtonWithHitTestInset: UIButton {
    var hitTestInset: UIEdgeInsets?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let extendedEdges = hitTestInset {
            let hitFrame = CGRect(x: bounds.minX  - extendedEdges.left, y: bounds.minY - extendedEdges.top, width: bounds.width + extendedEdges.left + extendedEdges.right, height: bounds.height + extendedEdges.top + extendedEdges.bottom)
            return hitFrame.contains(point)
        } else {
            return super.point(inside: point, with: event)
        }
    }
}
