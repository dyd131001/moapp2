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
    @State private var showEdit: Bool = false
    
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
                        VStack{
                            Text(category.title)
                                .font(.custom("tag", size: 5))
                                .padding(.horizontal,5)
                                .padding(.vertical,5)
                                .background(.pink)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            
                            Text(plan.title)
                                .font(.caption2)
                                .foregroundColor(.primary)
                                .padding(.top, 1)
             
                        }
                    case .detailPlan(let detailPlan):
                        VStack{
                            Text(category.title)
                                .font(.custom("tag", size: 10))
                                .padding(.horizontal,8)
                                .padding(.vertical,8)
                                .background(.pink)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            
                            Text(detailPlan.title)
                                .font(.caption2)
                                .foregroundColor(.primary)
                                .padding(.top, 1)
               
                        }
                        
                        
                    }
                }
                .onTapGesture {
                            showEdit = true
                        }
                .sheet(isPresented: $showEdit){
                    PlanDescription(isDetail: false , selectedDate: .constant(day), plans: plans, isPopup: true )
                        .clearModalBackground()
                
                    
                }
            }
        }
        .frame(minWidth: 40, minHeight: 120, alignment: .top)
        .onTapGesture {
                    showEdit = true
                }
        .sheet(isPresented: $showEdit){
            PlanDescription(isDetail: false , selectedDate: .constant(day), plans: plans , isPopup: true)
                .clearModalBackground()
        
            
        }
    }
    
    

}
