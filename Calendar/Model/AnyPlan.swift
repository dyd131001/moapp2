//
//  AnyPlan.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

enum AnyPlan: Identifiable {
    case plan(Plan)
    case detailPlan(DetailPlan)
    
    var id: UUID {
        switch self {
        case .plan(let plan):
            return plan.id
        case .detailPlan(let detailPlan):
            return detailPlan.id
        }
    }
}
