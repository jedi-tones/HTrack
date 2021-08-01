//
//  CGRect+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit

extension CGRect {
    func hitFrame(_ insets: UIEdgeInsets = UIEdgeInsets(top: 8,
                                                        left: 8,
                                                        bottom: 8,
                                                        right: 8)) -> CGRect {
        let extendedEdges = insets
        let hitFrame = CGRect(x: self.minX  - extendedEdges.left,
                              y: self.minY - extendedEdges.top,
                              width: self.width + extendedEdges.left + extendedEdges.right,
                              height: self.height + extendedEdges.top + extendedEdges.bottom)
        return hitFrame
    }
}

