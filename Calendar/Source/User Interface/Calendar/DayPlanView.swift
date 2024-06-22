//
//  PlanView.swift
//  Calendar
//
//  Created by 박정용 on 6/16/24.
//

import SwiftUI

struct DayPlanView: View {
    
    let category : Category
    let title : String
    let isComplete : Bool
    
    var body: some View {
        VStack {
            
            Text(category.title)
                .font(.custom("tag", size: 5))
                .padding(.horizontal,5)
                .padding(.vertical,5)
                .background(.pink)
                .foregroundColor(.white)
                .cornerRadius(20)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(isComplete ? .gray : .primary)
                .strikethrough(isComplete, color: .gray)
                .padding(.top, 1)
        }
    }
}

