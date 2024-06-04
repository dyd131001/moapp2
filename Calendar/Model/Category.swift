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

}

let CategorySample = [
    Category(title: "일상", color: "pink")
]


extension Category: Codable {}
extension Category: Equatable {}
extension Category: Hashable {}

