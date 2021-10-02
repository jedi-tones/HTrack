//
//  ScrollableContent.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

protocol ScrollableContent  {
    var scrollViewDelegate : UIScrollViewDelegate? { get set }
    
    func scrollToTop()
}
