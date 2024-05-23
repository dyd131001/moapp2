//
//  Store.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import Foundation

final class CategoryStore: ObservableObject {
    var category:[Category]
    
    init(filename: String = "Data.json") {
        self.category = Bundle.main.decode(filename: filename, as: [Category].self)
    }
}

