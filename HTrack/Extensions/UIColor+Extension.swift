//
//  Color+Extension.swift
//  HTrack
//
//  Created by Jedi Tones on 15.11.2021.
//

import UIKit

extension UIColor {
    static func withGradient(colors: [UIColor], rect: CGRect, startPoint: CGPoint = .init(x: 1.0, y: 0.0), endPoint: CGPoint = .init(x: 0.0, y: 1.0)) -> UIColor? {
        
        var locations = [NSNumber]()
        var number: Double = 0.0
        let increment: Double = 1.0 / Double(colors.count - 1)
        
        for _ in 0 ..< colors.count {
            locations.append(NSNumber(value: number))
            number += increment
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        
        return UIColor(patternImage: image)
    }
}
