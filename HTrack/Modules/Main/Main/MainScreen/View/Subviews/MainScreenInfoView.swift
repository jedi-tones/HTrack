//
//  MainScreenInfoView.swift
//  HTrack
//
//  Created by Jedi Tones on 9/20/21.
//

import UIKit
import TinyConstraints

class MainScreenInfoView: UIView {
    
    var descLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.text = "Дней без алкоголя:"
        lb.textAlignment = .center
        return lb
    }()
    
    var countLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeMainScreen).font
        lb.text = "0"
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(descLabel)
        addSubview(countLabel)
        
        countLabel.edgesToSuperview(excluding: .top, usingSafeArea: true)
        descLabel.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        descLabel.bottomToTop(of: countLabel, offset: -40)
    }
    
    func setup(vm: MainScreenInfoViewModel) {
        DispatchQueue.main.async {[weak self] in
            self?.descLabel.text = vm.title
            self?.countLabel.text = vm.count
        }
    }
}
