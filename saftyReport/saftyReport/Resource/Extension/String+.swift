//
//  String+.swift
//  saftyReport
//
//  Created by 김유림 on 11/29/24.
//

import Foundation

extension String {
    /// 서버에서 받은 문자열의 특수문자(`\\r\\n`, `\\n`, `\\r`)를 실제 줄바꿈 문자로 변환
    func replaceEscapeSequences() -> String {
        self.replacingOccurrences(of: "\\r\\n ", with: "\n\(String.bullet) ")
            .replacingOccurrences(of: "\\r ", with: "\r\(String.bullet) ")
            .replacingOccurrences(of: "\\n ", with: "\n\(String.bullet) ")
            .replacingOccurrences(of: "\\r\\n", with: "\n\(String.bullet) ")
            .replacingOccurrences(of: "\\r", with: "\r\(String.bullet) ")
            .replacingOccurrences(of: "\\n", with: "\n\(String.bullet) ")
            
    }
    
    /// 양쪽의 큰따옴표를 제거하는 함수
    func removeQuotes() -> String {
        self.trimmingCharacters(in: .init(charactersIn: "\""))
    }
    
    static let bullet = "•"
}
