//
//  FriendsCustomNavigationView.swift
//  HTrack
//
//  Created by Jedi Tones on 9/20/21.
//

import UIKit
import TinyConstraints

class FriendsCustomNavigationView: UIView {
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = labelColor
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBig).font
        lb.text = "@NICKNAME"
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = backColor
    }
    
    private func setupConstraints() {
        addSubview(nameLabel)
        
        nameLabel.edgesToSuperview()
    }
    
    @discardableResult
    func updateTitle(title: String) -> Self {
        
        DispatchQueue.main.async {[weak self] in
            self?.nameLabel.text = "@\(title.uppercased())"
        }
        
        return self
    }
}

extension FriendsCustomNavigationView {
    var backColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
    
    var labelColor: UIColor {
        Styles.Colors.myLabelColor()
    }
}
