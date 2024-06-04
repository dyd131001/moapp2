//
//  DayView.swift
//  Calendar
//
//  Created by 박정용 on 6/4/24.
//

import SwiftUI

struct DayView: View {
    let day: Date
    let plans: [Category: [AnyPlan]]
    let dateFormatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .center) {
            Text(dateFormatter.string(from: day)) // 날짜
                .font(.caption)
                .foregroundColor(.gray)
            
            // 해당 날짜의 일정을 로드하여 표시
            ForEach(plans.keys.sorted(by: { $0.title < $1.title }), id: \.self) { category in
                ForEach(plans[category] ?? [], id: \.id) { anyPlan in
                    switch anyPlan {
                    case .plan(let plan):
                        Text(plan.title)
                            .font(.caption2)
                            .foregroundColor(.primary)
                            .padding(.top, 1)
                            .onTapGesture {
                                // Plan 클릭 이벤트
                                print("Plan tapped: \(plan.title)")
                            }
                    case .detailPlan(let detailPlan):
                        Text(detailPlan.title)
                            .font(.caption2)
                            .foregroundColor(.primary)
                            .padding(.top, 1)
                            .onTapGesture {
                                // DetailPlan 클릭 이벤트
                                print("DetailPlan tapped: \(detailPlan.title)")
                            }
                    }
                }
            }
        }
        .frame(minWidth: 40, minHeight: 120, alignment: .top)
    }
}
