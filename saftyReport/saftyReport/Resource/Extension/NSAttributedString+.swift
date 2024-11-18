//
//  NSAttributedString.swift
//  saftyReport
//
//  Created by 김유림 on 11/18/24.
//

import UIKit

extension NSAttributedString {
    static func styled(text: String, style: TextStyle, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = style.lineHeight
        paragraphStyle.maximumLineHeight = style.lineHeight
        paragraphStyle.alignment = alignment

        let attributes: [NSAttributedString.Key: Any] = [
            .font: style.font,
            .paragraphStyle: paragraphStyle
        ]

        return NSAttributedString(string: text, attributes: attributes)
    }
}
