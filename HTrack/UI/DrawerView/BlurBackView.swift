//
//  BlurBackView.swift
//  HTrack
//
//  Created by Jedi Tones on 10/2/21.
//

import UIKit
import TinyConstraints

class BlurBackgroundView: UIView {
    private var backView1: UIView!
    private var backView2: UIView!
    private var blurView: UIVisualEffectView!
    
    private var blurColor: UIColor?
    private var blurEffectStyle: UIBlurEffect.Style?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backView1 = UIView()
        backView1.isUserInteractionEnabled = false
        self.addSubview(backView1)
        
        backView1.edgesToSuperview()
        
        blurView  = UIVisualEffectView()
        blurView.isUserInteractionEnabled = false
        backView1.addSubview(blurView)
        
        blurView.edgesToSuperview()
        
        backView2 = UIView()
        backView2.isUserInteractionEnabled = false
        backView1.addSubview(backView2)
        
        backView2.edgesToSuperview()
        
        updateView()
    }
}

extension BlurBackgroundView {
    func setCustomBlurColor(color: UIColor? = nil, blurEffectStyle: UIBlurEffect.Style? = nil) {
        self.blurColor = color
        self.blurEffectStyle = blurEffectStyle
        
        updateView()
    }
    
    private func updateView() {
        blurView.effect = UIBlurEffect.init(style: .systemMaterial)
        
        backView1.backgroundColor = Styles.Colors.myBackgroundColor().withAlphaComponent(0)
        backView2.backgroundColor = blurColor ?? Styles.Colors.myBackgroundColor()
    }
}
