//
//  DetailPlan.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import Foundation

struct DetailPlan: Identifiable {
    let id = UUID()
    let startDate: String
    let endDate: String
    let title: String
    let content: String
    var complete: Bool = false
}

extension DetailPlan: Decodable {}
extension DetailPlan: Equatable {}


