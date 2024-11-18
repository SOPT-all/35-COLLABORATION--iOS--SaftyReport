//
//  TextStyle.swift
//  saftyReport
//
//  Created by 김유림 on 11/18/24.
//

import UIKit

struct TextStyle {
    let font: UIFont
    let lineHeight: CGFloat
    
    static let heading1 = TextStyle(
        font: UIFont.pretendard(weight: .semibold, size: 20),
        lineHeight: 24
    )
    
    static let heading2 = TextStyle(
        font: UIFont.pretendard(weight: .bold, size: 18),
        lineHeight: 21
    )
    
    static let body1 = TextStyle(
        font: UIFont.pretendard(weight: .extraBold, size: 16),
        lineHeight: 20
    )
    
    static let body2 = TextStyle(
        font: UIFont.pretendard(weight: .bold, size: 16),
        lineHeight: 20
    )
    
    static let body3 = TextStyle(
        font: UIFont.pretendard(weight: .semibold, size: 16),
        lineHeight: 24
    )
    
    static let body4 = TextStyle(
        font: UIFont.pretendard(weight: .bold, size: 15),
        lineHeight: 18
    )
    
    static let body5 = TextStyle(
        font: UIFont.pretendard(weight: .regular, size: 15),
        lineHeight: 18
    )
    
    static let body6 = TextStyle(
        font: UIFont.pretendard(weight: .bold, size: 14),
        lineHeight: 17
    )
    
    static let body7 = TextStyle(
        font: UIFont.pretendard(weight: .bold, size: 14),
        lineHeight: 20
    )
    
    static let body8 = TextStyle(
        font: UIFont.pretendard(weight: .medium, size: 14),
        lineHeight: 17
    )
    
    static let body9 = TextStyle(
        font: UIFont.pretendard(weight: .medium, size: 14),
        lineHeight: 20
    )
    
    static let caption1 = TextStyle(
        font: UIFont.pretendard(weight: .bold, size: 12),
        lineHeight: 14
    )
    
    static let caption2 = TextStyle(
        font: UIFont.pretendard(weight: .semibold, size: 12),
        lineHeight: 14
    )
    
    static let caption3 = TextStyle(
        font: UIFont.pretendard(weight: .medium, size: 12),
        lineHeight: 14
    )
    
    static let caption4 = TextStyle(
        font: UIFont.pretendard(weight: .regular, size: 12),
        lineHeight: 19
    )
    
    static let caption5 = TextStyle(
        font: UIFont.pretendard(weight: .bold, size: 10),
        lineHeight: 12
    )
    
    static let caption6 = TextStyle(
        font: UIFont.pretendard(weight: .semibold, size: 10),
        lineHeight: 12
    )
    
    static let caption7 = TextStyle(
        font: UIFont.pretendard(weight: .medium, size: 10),
        lineHeight: 12
    )
    
    static let caption8 = TextStyle(
        font: UIFont.pretendard(weight: .bold, size: 8),
        lineHeight: 10
    )
    
    static let caption9 = TextStyle(
        font: UIFont.pretendard(weight: .medium, size: 8),
        lineHeight: 10
    )
}
