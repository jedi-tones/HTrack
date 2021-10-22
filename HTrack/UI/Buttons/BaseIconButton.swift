//
//  BaseIconButton.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import TinyConstraints
import UIKit

class BaseIconButton: BaseCustomButton {
    
    let icon: UIImageView = {
        let imageView = UIImageView(image: Styles.Images.closeCross)
        return imageView
    }()
    
    var iconInsets = UIEdgeInsets(top: Styles.Sizes.baseHInset,
                                  left: Styles.Sizes.baseHInset,
                                  bottom: Styles.Sizes.baseHInset,
                                  right: Styles.Sizes.baseHInset) {
        didSet {
            iconConstraint?.deActivate()
            iconConstraint?.removeAll()
            iconConstraint = icon.edgesToSuperview(insets: iconInsets)
        }
    }
    
    private var iconConstraint: Constraints?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(icon)
        
        iconConstraint = icon.edgesToSuperview(insets: iconInsets)
    }
    
    @discardableResult
    func setIcon(_ icon: UIImage) -> Self {
        self.icon.image = icon
        
        return self
    }
}
