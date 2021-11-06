//
//  DrawerView.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit
import TinyConstraints

protocol DrawerViewListener: AnyObject {
    func drawerView(_ drawerView: DrawerView, willBeginAnimationToState state: DrawerView.State?)
    func drawerView(_ drawerView: DrawerView, didEndAnimationToState state: DrawerView.State?)
}

class DrawerView : UIView {
    enum State: Equatable {
        case top
        case middle
        case bottom
        case dismissed
        case custom(height: CGFloat)
    }
    
    var enabledState: [State] = [.top, .dismissed]
    private let notifier = Notifier<DrawerViewListener>()
    
    var dragRecognizer: UIPanGestureRecognizer!
    var backTouchRecognizer: UITapGestureRecognizer!
    
    let animationDamping: CGFloat = Styles.Constants.animationDamping
    let animationDuration  = Styles.Constants.animationDuarationBase
    let animationDurationMedium  = Styles.Constants.animationDuarationMedium
    let maxHeight: CGFloat = Styles.Sizes.screenSize.height - Styles.Sizes.statusBar.height
    var maxDrawerPosition: CGFloat = Styles.Sizes.screenSize.height - Styles.Sizes.statusBar.height - (Styles.Sizes.standartV2Inset * 6) {
        didSet {
            midDrawerPosition = maxDrawerPosition/2
        }
    }
    
    lazy var midDrawerPosition: CGFloat = (maxDrawerPosition / 2) + Styles.Sizes.statusBar.height
    lazy var _minDrawerPosition: CGFloat = headerView.height
    var minDrawerPosition: CGFloat {
        get {
            _minDrawerPosition
        }
        
        set {
            _minDrawerPosition = newValue + Styles.Sizes.safeAreaInsets.bottom
        }
    }
    
    var startDragHeight:CGFloat = 0
    var contentsOffsetTop: CGFloat = 0
    var drawerHeight: CGFloat = 0
    
    var isScrollViewBeingDragged: Bool = false
    
    var backgroundView: UIView = UIView()
    var blurBackgroundView = BlurBackgroundView()
    
    var needChangeHeaderAlpha = true {
        didSet {
            if !needChangeHeaderAlpha {
                headerView.headerBlurAlpha = 0
            }
        }
    }
    
    var containerView: ViewWithCustomTouchArea = {
        let view = ViewWithCustomTouchArea()
        view.isHidden = true
        view.touchAreaInsets = UIEdgeInsets(top: 15, left: .zero, bottom: .zero, right: .zero)
        view.addShadow(offset: CGSize(width: 0, height: 10),
                       color: Styles.Colors.myShadowColor().withAlphaComponent(0.2),
                       radius: 30,
                       opacity: 1)
        
        return view
    }()
    
    lazy var headerView: DrawerHeaderView = {
        let headerView = DrawerHeaderView()
        return headerView
    }()
    
    open var cornerRadius: CGFloat {
        set {
            let cornerRadius: CGFloat
            let maskedCorners: CACornerMask
            let mask: Bool
            if newValue > 0 {
                mask = true
                cornerRadius = newValue
                maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else {
                mask = false
                cornerRadius = 0
                maskedCorners = []
            }
            
            containerView.layer.cornerRadius = cornerRadius
            containerView.layer.maskedCorners = maskedCorners
            
            headerView.layer.masksToBounds = mask
            headerView.layer.cornerRadius = cornerRadius
            headerView.layer.maskedCorners = maskedCorners
            
            drawerContentView?.layer.masksToBounds = mask
            drawerContentView?.layer.cornerRadius = cornerRadius
            drawerContentView?.layer.maskedCorners = maskedCorners
            
            containerView.subviews.forEach { (view) in
                if view is BlurBackgroundView {
                    view.layer.masksToBounds = true
                    view.layer.cornerRadius = cornerRadius
                    view.layer.maskedCorners = maskedCorners
                }
            }
        }
        get {
            headerView.layer.cornerRadius
        }
    }
    
    var drawerContentView: UIView? {
        willSet {
            if let drawerContentView = drawerContentView {
                drawerContentView.removeFromSuperview()
            }
        }
        
        didSet {
            guard let drawerContentView = drawerContentView else { return }
            
            containerView.addSubview(drawerContentView)
            containerView.bringSubviewToFront(headerView)
            
            drawerContentView.edgesToSuperview()
            
            if containerView.layer.cornerRadius > 0 {
                drawerContentView.layer.masksToBounds = true
                drawerContentView.layer.cornerRadius = containerView.layer.cornerRadius
                drawerContentView.layer.maskedCorners = containerView.layer.maskedCorners
            }
        }
    }
    
    var scrollableContent : ScrollableContent? {
        willSet {
            scrollableContent?.scrollViewDelegate = nil
        }
        
        didSet {
            scrollableContent?.scrollViewDelegate = self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    func setDrawerPosition(_ position: State,
                           animated: Bool = true,
                           slowAnimate: Bool = false,
                           fastUpdate: Bool = false,
                           delay: TimeInterval = 0.0,
                           completion: @escaping () -> Void) {
        
        var newSize = containerView.frame.size
        var oldSize = containerView.frame.size
        
        func updateDrawer() {
            containerView.frame = CGRect(origin: CGPoint(x: 0, y: Styles.Sizes.screenSize.height-drawerHeight),
                                         size: oldSize)
        }
        
        func updatePosition() {
            containerView.isHidden = false
            
            newSize.height = self.drawerHeight
            
            if newSize.height > oldSize.height {
                oldSize.height = self.drawerHeight
            }
            
            containerView.frame = CGRect(origin: containerView.frame.origin,
                                         size: newSize)
            
            if animated {
                UIView.animate(withDuration: slowAnimate ? animationDuration : animationDurationMedium,
                               delay: delay,
                               usingSpringWithDamping: animationDamping,
                               initialSpringVelocity: 0,
                               options: [ .beginFromCurrentState ],
                               animations: {
                                updateDrawer()
                                self.backgroundView.alpha = position == .bottom ? 0 : 1
                               },
                               completion: {_ in
                                oldSize.height = self.drawerHeight
                                updateDrawer()
                                self.notifier.forEach { $0.drawerView(self,
                                                                      didEndAnimationToState: position)}
                                completion()
                })
            } else if fastUpdate {
                oldSize.height = self.drawerHeight
                updateDrawer()
                self.notifier.forEach { $0.drawerView(self,
                                                      didEndAnimationToState: position)}
                completion()
            } else {
                UIView.animate(withDuration: animationDuration/2) {
                    updateDrawer()
                    self.backgroundView.alpha = position == .bottom ? 0 : 1
                } completion: { (_) in
                    oldSize.height = self.drawerHeight
                    updateDrawer()
                    self.notifier.forEach { $0.drawerView(self,
                                                          didEndAnimationToState: position)}
                    completion()
                }
            }
        }
        
        notifier.forEach { $0.drawerView(self, willBeginAnimationToState: position)}
        
        switch position {
        case .top:
            drawerHeight = maxDrawerPosition
            updatePosition()
            
        case .middle:
            drawerHeight = midDrawerPosition
            updatePosition()
            
        case .bottom:
            drawerHeight = minDrawerPosition
            updatePosition()
            
        case .custom(let height):
            drawerHeight = height
            updatePosition()
            
        case .dismissed:
            guard drawerHeight != 0 else {
                completion()
                return
            }
            
            drawerHeight = 0
            
            UIView.animate(withDuration: animationDuration, animations: {
                self.backgroundView.alpha = 0
                updateDrawer()
            }) { _ in
                self.notifier.forEach { $0.drawerView(self, didEndAnimationToState: position)}
                self.containerView.isHidden = true
                completion()
            }
        }
    }
    
    private func setupViews() {
        backgroundView.alpha = 0
        
        addSubview(backgroundView)
        addSubview(containerView)
        
        backgroundView.edgesToSuperview()
        
        containerView.addSubview(blurBackgroundView)
        containerView.addSubview(headerView)
        
        blurBackgroundView.edgesToSuperview()
        
        setupGestureRecognizer()
        setupConstraints()
        
        cornerRadius = 0
        
        updateViewColor()
    }
    
    private func setupConstraints() {
        //drawerHeightConstraint = containerView.height(0)
        //drawerHiddenConstraint = containerView.topToBottom(of: self)
        //drawerShownConstraint = containerView.bottomToSuperview()
        
        //containerView.leftToSuperview()
        //containerView.rightToSuperview()
        //containerView.bottomToSuperview()
        
        containerView.frame = CGRect(origin: CGPoint(x: 0, y: Styles.Sizes.screenSize.height),
                                     size: CGSize(width: Styles.Sizes.screenSize.width, height: 0))
        
        headerView.leftToSuperview()
        headerView.rightToSuperview()
        headerView.topToSuperview()
        headerView.height(cornerRadius, relation: .equalOrGreater, priority: .defaultLow)
        headerView.bottomToSuperview(offset: 0, relation: .equalOrLess, priority: .defaultHigh)
    }
    
    deinit {
        Logger.show(title: "DrawerView", text: "\(type(of: self)) - \(#function)")
    }
}

extension DrawerView {
    var headerHeight: CGFloat {
        return headerView.frame.height
    }
    
    var shouldDrag : Bool {
        return drawerHeight < maxDrawerPosition
    }
}

extension DrawerView {
    func addListener(_ listener: DrawerViewListener) {
        notifier.subscribe(listener)
    }
    
    func removeListener(_ listener: DrawerViewListener) {
        notifier.unsubscribe(listener)
    }
}

extension DrawerView {
    func setHeader(view: UIView) {
        headerView.addHeader(view: view)
    }
    
    func setCustomHeaderColor(color: UIColor) {
        headerView.setBlurViewColor(color)
    }
    
    func setNeedChangeHeaderAlpha(needChage: Bool) {
        self.needChangeHeaderAlpha = needChage
    }
    
    func clearBackgroundColor() {
        self.backgroundView.backgroundColor = .clear
    }

}

extension DrawerView {
    private func updateViewColor() {
        backgroundColor = .clear
        containerView.backgroundColor  = .clear
        blurBackgroundView.setCustomBlurColor(color: Styles.Colors.myBackgroundColor(),
                                              blurEffectStyle: .systemMaterial)
        backgroundView.backgroundColor = Styles.Colors.base2.withAlphaComponent(0.2)
    }
}
