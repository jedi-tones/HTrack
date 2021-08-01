//
//  ViewWithCustomTouchArea.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit

class ViewWithCustomTouchArea: UIView {
    var touchAreaInsets: UIEdgeInsets = UIEdgeInsets(top: 5,
                                                     left: 5,
                                                     bottom: 5,
                                                     right: 5)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = bounds.inset(by: touchAreaInsets.inverted())
        return rect.contains(point)
    }
}
