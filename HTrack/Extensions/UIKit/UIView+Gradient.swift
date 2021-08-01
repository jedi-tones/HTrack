//
//  UIView+Gradient.swift
//  HTrack
//
//  Created by Jedi Tones on 7/31/21.
//

import UIKit

extension UIView {
    @discardableResult
    func addGradient(colors: [UIColor], locations: [NSNumber], startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) -> CAGradientLayer {
        let gradientLayer: CAGradientLayer
        
//        if let layer = self.layer.sublayers?.first as? CAGradientLayer {
//            gradientLayer = layer
//        } else {
            gradientLayer = CAGradientLayer()
            self.layer.insertSublayer(gradientLayer, at: 0)
//        }
        
        gradientLayer.colors = colors.compactMap({ $0.cgColor })
        gradientLayer.locations = locations
        
        if let startPoint = startPoint {
            gradientLayer.startPoint = startPoint
        }
        
        if let endPoint = endPoint {
            gradientLayer.endPoint = endPoint
        }
        
        gradientLayer.frame = self.bounds
        return gradientLayer
    }
    
    func removeGradient(_ gradientLayer: CAGradientLayer) {
        gradientLayer.removeFromSuperlayer()
    }
    
    @discardableResult
    func addGradient(colors: [UIColor], locations: [NSNumber], angle: Float = 0) -> CAGradientLayer {
        let direction: Float = angle / 360
        
        let startPointX = powf(sinf(2 * Float.pi * ((direction + 0.75) / 2)), 2)
        let startPointY = powf(sinf(2 * Float.pi * ((direction + 0) / 2)), 2)
        let endPointX = powf(sinf(2 * Float.pi * ((direction + 0.25) / 2)), 2)
        let endPointY = powf(sinf(2 * Float.pi * ((direction + 0.5) / 2)), 2)
        
        let startPoint = CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
        let endPoint = CGPoint(x: CGFloat(endPointX),y: CGFloat(endPointY))
        
        return addGradient(colors: colors, locations: locations, startPoint: startPoint, endPoint: endPoint)
    }
    
    /// Adds a gradient with more than one color. Location is calculated automatically, the calculation is based on the number of colors.
    /// - angle points: (x: 0, y: 1) -> (x: 1, y: 0)
    func addAngleGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 1), endPoint: CGPoint = CGPoint(x: 1, y: 0)) {
        var locations = [NSNumber]()
        var number: Double = 0.0
        let increment: Double = 1.0 / Double(colors.count - 1)
        
        for _ in 0 ..< colors.count {
            locations.append(NSNumber(value: number))
            number += increment
        }
        
        let gradientLayer: CAGradientLayer
        
        if let layer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer}) as? CAGradientLayer {
            gradientLayer = layer
        } else {
            gradientLayer = CAGradientLayer()
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        gradientLayer.colors = colors.compactMap { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
    }
    
    @discardableResult
    func addFade(color: UIColor = Styles.Colors.myLabelColor().withAlphaComponent(0.3)) -> CALayer {
        let fadeLayer = CALayer()
        fadeLayer.backgroundColor = color.cgColor
        fadeLayer.frame = self.bounds
        self.layer.insertSublayer(fadeLayer, at: 0)
        
        return fadeLayer
    }
}
