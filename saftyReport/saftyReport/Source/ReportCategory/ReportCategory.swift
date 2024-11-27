//
//  ReportCategory.swift
//  saftyReport
//
//  Created by 김유림 on 11/27/24.
//

import Foundation

struct ReportCategory {
    enum Section: Int, CaseIterable {
        case safety = 1
        case parking = 2
        case traffic = 3
        case environment = 4
    }
    
    enum ToggleState {
        case normal, expanded
    }
    
    struct Item: Hashable {
//        let id: Int
        let section: Section
        let name: String
        let description: String
        var toggleState: ToggleState
    }
}

extension ReportCategory {
    struct Dummy {
        static let safety = [ReportCategory.Item(section: .safety, name: "안전", description: "\"가을철 집중 사고 \\r\\n 도로시설물 파손 및 고장\\r\\n 건설(해체)공사장 위험\\r\\n 대기오염 \\r\\n 수질오염 \\r\\n 소방안전 \\r\\n 기타 안전/환경 위험요소\"", toggleState: .expanded)]
        
        static let parking = [ReportCategory.Item(section: .safety, name: "불법 주정차", description: "\"소화전 \\r\\n 교차로 모퉁이 \\r\\n 버스 정류소 \\r\\n 횡단보도 \\r\\n 어린이 보호구역 \\r\\n 인도 \\r\\n 장애인 전용구역 \\r\\n 소방차 전용구역 \\r\\n 친환경차 전용구역 \\r\\n 기타\"", toggleState: .normal)]
        
        static let traffic = [ReportCategory.Item(section: .traffic, name: "자동차/교통위반", description: "\"교통위반(고속도로 포함) \\r\\n \"이륜차 위반\" \\r\\n 버스전용차로 위반(고속도로 제회) \\r\\n 불법동화, 반사판(지) 가림, 손상 \\r\\n 불법 튜닝, 해체, 조작 \\r\\n 기타 자동차 안전기준 위반", toggleState: .expanded)]
        
        static let environment = [ReportCategory.Item(section: .environment, name: "생활불편", description: "\"불법광고물 \\r\\n 자전거/이륜차 방치 및 불편 \\r\\n 자전거/이륜차 방치 및 불편 \\r\\n쓰레기, 폐기물 \\r\\n해양 쓰레기 \\r\\n 기타 생활불편\"", toggleState: .normal)]
    }
}
