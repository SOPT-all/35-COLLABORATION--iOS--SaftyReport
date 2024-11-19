//
//  UIFont+Extension.swift
//  saftyReport
//
//  Created by 김유림 on 11/18/24.
//

import UIKit

extension UIFont {
    enum PretendardWeight: String {
        case black = "Pretendard-Black"
        case bold = "Pretendard-Bold"
        case extraBold = "Pretendard-ExtraBold"
        case extraLight = "Pretendard-ExtraLight"
        case light = "Pretendard-Light"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semibold = "Pretendard-SemiBold"
        case thin = "Pretendard-Thin"
    }
    
    static func pretendard(weight: PretendardWeight, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: size) else {
            print("🤥 Pretendard 폰트 변환 실패")
            return .systemFont(ofSize: size)
        }
        
        return font
    }
}
