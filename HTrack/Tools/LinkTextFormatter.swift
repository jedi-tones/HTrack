//
//  LinkTextFormatter.swift
//  HTrack
//
//  Created by Jedi Tones on 8/1/21.
//

import UIKit

class LinkTextFormatter {
    struct Link {
        let text: String
        let url: URL
    }

    private let textColor: UIColor
    private let font: UIFont
    private let paragraphStyle: NSParagraphStyle

    init(textColor: UIColor) {
        self.font = Styles.Fonts.AvenirFonts.AvenirNextUltraLight(size: Styles.Sizes.fontSizeSmall).font
        self.textColor = textColor
        self.paragraphStyle = {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 0.1
            return style
        }()
    }

    init(textColor: UIColor, font: UIFont, paragraphStyle: NSParagraphStyle?) {
        self.textColor = textColor
        self.font = font
        if let paragraphStyle = paragraphStyle {
            self.paragraphStyle = paragraphStyle
        } else {
            self.paragraphStyle = {
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 0.1
                return style
            }()
        }
    }

    func attributedText(text: String, link: Link) -> NSAttributedString {
        attributedText(text: text, links: [link])
    }

    func attributedText(text: String, links: [Link]) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .foregroundColor: textColor,
                .backgroundColor: UIColor.clear,
                .font: font
            ]
        )

        let textAsNsstring = text as NSString
        let linkRanges = links.map { textAsNsstring.range(of: $0.text) }
        guard linkRanges.allSatisfy({ $0.length != 0 }) else { return NSMutableAttributedString(string: text) }

        zip(links, linkRanges).forEach { link, range in
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.foregroundColor, value: textColor, range: range)
            attributedText.addAttribute(.link, value: link.url, range: range)
        }

        return attributedText
    }
    
    func attributedText(attributedString: NSMutableAttributedString, links: [Link]) -> NSMutableAttributedString {
        let attributedText = attributedString

        let textAsNsstring = attributedText.string as NSString
        let linkRanges = links.map { textAsNsstring.range(of: $0.text) }
        guard linkRanges.allSatisfy({ $0.length != 0 }) else { return attributedText }

        zip(links, linkRanges).forEach { link, range in
            attributedText.addAttribute(.link, value: link.url, range: range)
            attributedText.addAttribute(.font, value: font, range: range)
            attributedText.addAttribute(.foregroundColor, value: textColor, range: range)
        }

        return attributedText
    }
}
