//
//  UIView+Size.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

extension UIView {
    /// Size of view.
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    /// Width of view.
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// Height of view.
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var smallestCalculatedConstraintsSize: CGSize {
        return systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
