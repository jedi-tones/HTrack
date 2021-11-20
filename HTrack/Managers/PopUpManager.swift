//
//  PopUpManager.swift
//  HTrack
//
//  Created by Jedi Tones on 9/20/21.
//

import UIKit
import SwiftEntryKit

class PopUpManager {
    static let shared = PopUpManager()
    private init() {}
    
    func showViewPopUp(view: UIView, withAnimation: Bool, name: String){
        var attributes = EKAttributes()
        attributes.name = name
        attributes.displayMode = .inferred
        attributes.statusBar = .inferred
        attributes.windowLevel = .custom(level: .alert + 1)
        attributes.displayDuration = .infinity
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
        attributes.screenInteraction = .absorbTouches
        attributes.screenBackground = .color(color: EKColor.init(Styles.Colors.myBackgroundColor().withAlphaComponent(0.5)))
        attributes.position = .bottom
        if !withAnimation {
            attributes.entranceAnimation = .none
        }
        let constraints = EKAttributes.PositionConstraints.fullScreen
        attributes.positionConstraints = constraints
        attributes.hapticFeedbackType = .error
        attributes.positionConstraints.safeArea = .overridden
        //SwiftEntryKit.display(entry: view, using: attributes)
        SwiftEntryKit.display(entry: view, using: attributes, presentInsideKeyWindow: false, rollbackWindow: .main)
    }
    
    func showViewController(viewController: UIViewController, withAnimation: Bool, name: String){
        var attributes = EKAttributes()
        attributes.name = name
        attributes.displayMode = .inferred
        attributes.statusBar = .inferred
        attributes.windowLevel = .custom(level: .alert + 1)
        attributes.displayDuration = .infinity
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
        attributes.screenInteraction = .dismiss
        attributes.screenBackground = .color(color: EKColor.init(Styles.Colors.myBackgroundColor().withAlphaComponent(0.5)))
        attributes.position = .bottom
        if !withAnimation {
            attributes.entranceAnimation = .none
        }
        let constraints = EKAttributes.PositionConstraints.fullScreen
        attributes.positionConstraints = constraints
        
        attributes.hapticFeedbackType = .error
        attributes.positionConstraints.safeArea = .overridden
        //SwiftEntryKit.display(entry: view, using: attributes)
        SwiftEntryKit.display(entry: viewController, using: attributes)
    }
    
    //MARK: show info
    func showInfo(text: String){
        var attributes = EKAttributes()
        attributes = .topNote
        attributes.displayMode = .inferred
        attributes.displayDuration = 3
        attributes.name = "Top Info"
        attributes.hapticFeedbackType = .success
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .init(Styles.Colors.base1))
    
        let text = text
        let style = EKProperty.LabelStyle(
            font: Styles.Fonts.bold1,
            color: .init(Styles.Colors.base3),
            alignment: .center,
            numberOfLines: 2
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        let contentView = EKNoteMessageView(with: labelContent)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    func dismisPopUp(name: String, complition:@escaping()->()) {
        SwiftEntryKit.dismiss(.specific(entryName: name)) {
            complition()
        }
    }
    
    func dismisAllPopUp() {
        SwiftEntryKit.dismiss(.all)
    }
}
