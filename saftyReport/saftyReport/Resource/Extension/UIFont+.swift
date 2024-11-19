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
      static var heading01: UIFont { .pretendard(weight: .semibold, size: 20) }
      static var heading02: UIFont { .pretendard(weight: .bold, size: 18) }
      
      static var body01: UIFont { .pretendard(weight: .extraBold, size: 16) }
      static var body02: UIFont { .pretendard(weight: .bold, size: 16) }
      static var body03: UIFont { .pretendard(weight: .semibold, size: 16) }
      static var body04: UIFont { .pretendard(weight: .bold, size: 15) }
      static var body05: UIFont { .pretendard(weight: .regular, size: 15) }
      static var body06: UIFont { .pretendard(weight: .bold, size: 14) }
      static var body07: UIFont { .pretendard(weight: .bold, size: 14) }
      static var body08: UIFont { .pretendard(weight: .medium, size: 14) }
      static var body09: UIFont { .pretendard(weight: .medium, size: 14) }
      
      static var caption01: UIFont { .pretendard(weight: .bold, size: 12) }
      static var caption02: UIFont { .pretendard(weight: .semibold, size: 12) }
      static var caption03: UIFont { .pretendard(weight: .medium, size: 12) }
      static var caption04: UIFont { .pretendard(weight: .regular, size: 12) }
      static var caption05: UIFont { .pretendard(weight: .bold, size: 10) }
      static var caption06: UIFont { .pretendard(weight: .semibold, size: 10) }
      static var caption07: UIFont { .pretendard(weight: .medium, size: 10) }
      static var caption08: UIFont { .pretendard(weight: .bold, size: 8) }
      static var caption09: UIFont { .pretendard(weight: .medium, size: 8) }
}
