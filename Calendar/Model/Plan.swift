//
//  plan.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import Foundation

struct Plan: Identifiable {
    let id = UUID()
    let startDate: String
    let endDate: String
    let title: String
    var complete: Bool = false
}


extension Plan: Decodable {}
extension Plan: Equatable {}
