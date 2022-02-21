//
//  MainScreenInfoView.swift
//  HTrack
//
//  Created by Jedi Tones on 9/20/21.
//

import UIKit
import TinyConstraints

class MainScreenInfoView: UIView {
    fileprivate var descLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.base3
        lb.font = Styles.Fonts.soyuz2
        lb.text = ""
        lb.textAlignment = .left
        lb.numberOfLines = 3
        lb.layer.opacity = 0
        return lb
    }()
    
    fileprivate var countLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.base3
        lb.font = Styles.Fonts.soyuz3
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.2
        lb.text = "0"
        lb.textAlignment = .left
        lb.layer.opacity = 0
        return lb
    }()
    
    fileprivate var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.tintColor = Styles.Colors.base3
        return loader
    }()
    
    lazy var drinkButton: BaseTextButtonWithArrow = {
        let bt = BaseTextButtonWithArrow(insets: Styles.Sizes.mainScreenButtonInsets)
        bt.setTitle(title: LocDic.iDrank)
            .setTitleFont(font: Styles.Fonts.soyuz1)
            .setButtonColor(color: self.drinkButtonColor)
            .setTextColor(color: self.drinkButtonLabelColor)
            .setBorderColor(color: self.drinkButtonLabelColor)
    
        return bt
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = Styles.Sizes.standartV2Inset
        sv.distribution = .equalSpacing
        sv.alignment = .leading
        return sv
    }()
    
    fileprivate var containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(drinkButton)
        addSubview(containerView)
        
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(loader)
        stackView.addArrangedSubview(descLabel)
        
        drinkButton.leftToSuperview(offset: Styles.Sizes.standartH2Inset)
        drinkButton.bottomToSuperview(offset: -Styles.Sizes.standartV2Inset, usingSafeArea: true)
        drinkButton.height(Styles.Sizes.baseButtonHeight)
        
        containerView.edgesToSuperview(excluding: .bottom)
        containerView.bottomToTop(of: drinkButton, offset: -Styles.Sizes.standartV2Inset)
        
        stackView.centerYToSuperview()
        stackView.leftToSuperview(offset: Styles.Sizes.standartH2Inset)
        stackView.rightToSuperview(offset: -Styles.Sizes.standartH2Inset)
    }
    
    func showLoader(isActive: Bool) {
        DispatchQueue.main.async {[weak self] in
            if isActive {
                
                UIView.animate(withDuration: Styles.Constants.animationDuarationMedium) {
                    self?.countLabel.layer.opacity = 0
                    self?.descLabel.layer.opacity = 0
                } completion: { isComplete in
                    self?.loader.startAnimating()
                }
            } else {
                self?.loader.stopAnimating()
                self?.countLabel.isHidden = false
                self?.descLabel.isHidden = false
                UIView.animate(withDuration: Styles.Constants.animationDuarationMedium) {
                    self?.countLabel.layer.opacity = 1
                    self?.descLabel.layer.opacity = 1
                }
            }
        }
    }
    
    func setup(vm: MainScreenInfoViewModel) {
        DispatchQueue.main.async {[weak self] in
            self?.descLabel.text = vm.title
            self?.countLabel.text = vm.count
        }
    }
}

extension MainScreenInfoView {
    var drinkButtonColor: UIColor {
        Styles.Colors.myBackgroundColor()
    }
    var drinkButtonLabelColor: UIColor {
        Styles.Colors.myLabelColor()
    }
}
