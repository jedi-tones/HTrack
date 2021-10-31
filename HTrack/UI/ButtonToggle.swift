//
//  ButtonToggle.swift
//  HTrack
//
//  Created by Jedi Tones on 30.10.2021.
//

import UIKit
import TinyConstraints

protocol ButtonToggleDelegate: AnyObject {
    func changeToIndex(index:Int)
}

class ButtonToggle: UIView {
    enum SegmentType {
        case text
        case icon
    }
    
    enum SegmentStyle {
        case full
        case scroll
    }
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.delegate = self
        sv.contentInset = .zero
        return sv
    }()
    
    private var buttonTitles: [String] = []
    internal var buttonImages: [UIImage] = []
    internal var buttons: [UIButton] = []
    internal lazy var selectorLineView: UIView = {
        let view = UIView()
        view.height(Styles.Sizes.selectorLineHeight)
        view.backgroundColor = selectorColor
        return view
    }()
    
    var sBackgroundColor: UIColor = .clear { didSet { updateTheme() }}
    var sTextColor: UIColor? { didSet { updateTheme() }}
    var sSelectorTextColor: UIColor? { didSet { updateTheme() }}
    var selectorViewCenterConstraint: Constraint?
    var selectorViewWidthConstraint: Constraint?
    var buttonSpacing: CGFloat = .zero
    var normalFont: UIFont = Styles.Fonts.normal2 {
        didSet {
            updateButtons()
        }
    }
    var selectedFont: UIFont = Styles.Fonts.bold2 {
        didSet {
            updateButtons()
        }
    }
    
    weak var buttonToggleDelegate: ButtonToggleDelegate?
    
    private(set) var selectedIndex : Int = 0 {
        didSet {
            guard buttons.count > selectedIndex else { return }
            
            for (buttonIndex, btn) in buttons.enumerated() {
                if buttonIndex == selectedIndex {
                    btn.isSelected = true
                } else {
                    btn.isSelected = false
                }
            }
        }
    }
    var segmentType: SegmentType = .text
    var segmentStyle: SegmentStyle = .full
    
    var buttonsBackgroundView = UIView()
    var buttonsStackView: UIStackView?
    
    lazy var buttonsStackInsets: UIEdgeInsets = {
        switch segmentStyle {
        case .full, .scroll:
            return UIEdgeInsets(top: Styles.Sizes.stadartVInset / 2,
                                left: Styles.Sizes.standartHInset,
                                bottom: Styles.Sizes.stadartVInset / 2,
                                right: Styles.Sizes.standartHInset)
        }
    }()
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    func setButtonImages(buttonImages: [UIImage]) {
        self.buttonImages = buttonImages
        updateView()
    }
    
    func setIndex(index: Int) {
        selectedIndex = index
        updateSelectedViewPosition()
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            if btn == sender {
                selectedIndex = buttonIndex
                buttonToggleDelegate?.changeToIndex(index: selectedIndex)
                scrollToButton(btn)
                updateSelectedViewPosition()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}

//Configuration View
extension ButtonToggle {
    private func updateView() {
        createButton()
        configStackView()
        self.layoutIfNeeded()
        
        updateTheme()
    }
    
    private func scrollToButton(_ btn: UIButton) {
        guard scrollView.contentSize.width > scrollView.frame.width else { return }
        
        var rect = btn.frame
        let resultX = ((btn.frame.minX + btn.frame.maxX ) / 2)
        let centerScroll = scrollView.frame.width / 2
        let centerContetSize = scrollView.contentSize.width / 2
        let maxXPoint = scrollView.contentSize.width - scrollView.frame.width + Styles.Sizes.standartH2Inset
        var xPoint = resultX + centerScroll - centerContetSize
        if xPoint < 0 {
            xPoint = 0
        } else if xPoint > maxXPoint {
            xPoint = maxXPoint
        }
        rect.origin.x = xPoint
        scrollView.setContentOffset(rect.origin, animated: true)
    }
    
    private func configStackView() {
        buttonsStackView = UIStackView(arrangedSubviews: buttons)
        
        guard let buttonsStackView = buttonsStackView else { return }
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.spacing = buttonSpacing
        
        self.addSubview(scrollView)
        scrollView.edgesToSuperview()
        scrollView.addSubview(buttonsBackgroundView)
        buttonsBackgroundView.addSubview(buttonsStackView)
        buttonsBackgroundView.addSubview(selectorLineView)
        
        selectorLineView.bottom(to: buttonsBackgroundView)
        
        if segmentStyle == .scroll {
            buttonsStackView.edgesToSuperview()
            
            buttonsBackgroundView.top(to: self)
            buttonsBackgroundView.bottom(to: self)
            buttonsBackgroundView.leadingToSuperview()
            buttonsBackgroundView.trailingToSuperview()
        } else {
            buttons.forEach({$0.width(to: self, multiplier: 0.5)})
            buttonsBackgroundView.edges(to: self)
            buttonsStackView.edgesToSuperview()
        }
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.forEach({$0.removeFromSuperview()})
        buttons.removeAll()
        
        switch segmentType {
        case .text:
            buttonTitles.forEach { (_) in
                let button = UIButton()
                button.addTarget(self, action:#selector(self.buttonAction(sender:)), for: .touchUpInside)
                buttons.append(button)
            }
            
        case .icon:
            buttonImages.forEach { (_) in
                let button = UIButton()
                button.imageView?.contentMode = .scaleAspectFit
                button.heightToWidth(of: button)
                button.addTarget(self, action:#selector(self.buttonAction(sender:)), for: .touchUpInside)
                buttons.append(button)
            }
        }
        updateButtons()
    }
    
    @objc func updateButtons() {
        buttons.forEach({ (button) in
            let index = buttons.firstIndex(of: button) ?? 0
            
            switch segmentType {
            case .text:
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                
                let normalAttr: [NSAttributedString.Key: Any] = [.font : normalFont,
                                                                 .foregroundColor : textColor,
                                                                 .paragraphStyle : paragraphStyle ]
                
                let selectedAttr: [NSAttributedString.Key: Any] = [.font : selectedFont,
                                                                   .foregroundColor : selectedTextColor,
                                                                   .paragraphStyle : paragraphStyle ]
                
                button.setAttributedTitle(NSAttributedString(string: buttonTitles[index],
                                                             attributes: normalAttr),
                                          for: .normal)
                
                
                button.setAttributedTitle(NSAttributedString(string: buttonTitles[index],
                                                             attributes: selectedAttr),
                                          for: .highlighted)
                
                button.setAttributedTitle(NSAttributedString(string: buttonTitles[index],
                                                             attributes: selectedAttr),
                                          for: .selected)
                
            case .icon:
                button.setImage(buttonImages[index].withRenderingMode(.alwaysTemplate).withTintColor(textColor),
                                for: .normal)

                button.setImage(buttonImages[index].withRenderingMode(.alwaysTemplate).withTintColor(selectedTextColor),
                                for: .highlighted)

                button.setImage(buttonImages[index].withRenderingMode(.alwaysTemplate).withTintColor(selectedTextColor),
                                for: .selected)
            }
        })
    }
    
    func updateSelectedViewPosition(animated: Bool = true) {
        guard buttons.count > selectedIndex else { return }
        
        let btn = buttons[selectedIndex]
        selectorViewWidthConstraint?.isActive = false
        selectorViewWidthConstraint = selectorLineView.width(to: btn)
        selectorViewCenterConstraint?.isActive = false
        selectorViewCenterConstraint = selectorLineView.centerX(to: btn)
        
        if animated {
            UIView.animate(withDuration: Styles.Constants.animationDuarationBase,
                           delay: .zero,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 1.0,
                           options: [.curveEaseOut, .allowUserInteraction],
                           animations: {
                            self.layoutIfNeeded()
            }, completion: nil)
        }
    }
}

extension ButtonToggle: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ///disable vertical scroll
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}

extension ButtonToggle  {
    func updateTheme() {
        buttonsBackgroundView.backgroundColor = sBackgroundColor
        selectorLineView.backgroundColor = selectorColor
        
        updateButtons()
    }
    
    var selectorColor: UIColor {
        return sSelectorTextColor ?? Styles.Colors.base3
    }
    
    var textColor: UIColor {
        return sTextColor ?? Styles.Colors.base3.withAlphaComponent(0.5)
    }
    
    var selectedTextColor: UIColor {
        sSelectorTextColor ?? Styles.Colors.base3
    }
}
