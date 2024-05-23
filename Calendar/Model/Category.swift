//
//  category.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    let title: String
    let color: String
    var plan: [Plan]
    var detailPlan: [DetailPlan]
}


extension Category: Decodable {}
extension Category: Equatable {}
