//
//  UIStackView+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach {[weak self] view in
            self?.removeArrangedSubview(view)
        }
    }
}
