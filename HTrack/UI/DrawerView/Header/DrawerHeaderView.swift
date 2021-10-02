//
//  DrawerHeaderView.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit

class DrawerHeaderView: UIView {
    var headerBlurAlpha: CGFloat{
        get { _blurView.alpha }
        set {
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase) {
                self._blurView.alpha = newValue
            }
        }
    }
    
    private var dragAccessoryViewColor: UIColor? {
        didSet {
            updateView()
        }
    }
    
    private var _dragAccessoryView: UIView = {
        let view = UIView()
        view.setCornerRadius(radius: 2.5)
        return view
    }()
    
    private var _blurView: BlurBackgroundView = {
        let view = BlurBackgroundView()
        view.alpha = 0
        return view
    }()
    
    private var _stackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.axis = .vertical
        sv.spacing = Styles.Sizes.mediumVInset
        return sv
    }()
    
    private var _dragAccessorySize = CGSize(width: 36, height: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(_blurView)
        _blurView.edgesToSuperview()
        
        addSubview(_dragAccessoryView)
        _dragAccessoryView.size(_dragAccessorySize)
        _dragAccessoryView.centerXToSuperview()
        _dragAccessoryView.topToSuperview(offset: Styles.Sizes.mediumVInset)
        
        addSubview(_stackView)
        
        _stackView.topToBottom(of: _dragAccessoryView)
        _stackView.leftToSuperview()
        _stackView.rightToSuperview()
        _stackView.bottomToSuperview()
        
        updateView()
    }
    
    private func updateView() {
        _dragAccessoryView.backgroundColor = dragAccessoryViewColor ?? Styles.Colors.myDragAccessoryColor()
    }
}

extension DrawerHeaderView {
    func addHeader(view: UIView) {
        _stackView.addArrangedSubview(view)
        view.layoutIfNeeded()
    }
    
    func setAccessoryViewColor(_ color: UIColor) {
        dragAccessoryViewColor = color
    }
    
    func setBlurViewColor(_ color: UIColor) {
        _blurView.setCustomBlurColor(color: color)
    }
}
