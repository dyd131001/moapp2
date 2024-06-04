//
//  plan.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import Foundation

struct Plan: Identifiable {
    let id = UUID()
    let startDate: Date
    let endDate: Date
    let title: String
    var complete: Bool = false
}

let planSample = [
    Plan(startDate: Date(), endDate: Date(), title: "모앱프"),
    Plan(startDate: Date(), endDate: Date(), title: "웹프")
]

extension Plan: Equatable {}
extension Plan: Codable {}
