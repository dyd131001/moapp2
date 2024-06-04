//
//  WeekdaysHeaderView.swift
//  Calendar
//
//  Created by 박정용 on 6/4/24.
//

import SwiftUI

struct WeekdaysHeaderView: View {
    private let calendar = Calendar.current
    
    var body: some View {
        HStack {
            ForEach(weekdays(), id: \.self) { weekday in
                Spacer()
                Text(weekday)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(minWidth: 300)
    }
    
    private func weekdays() -> [String] {
        return calendar.shortWeekdaySymbols
    }
}
