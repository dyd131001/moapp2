//
//  PlanDescription.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct PlanDescription: View {
    @EnvironmentObject private var planStore : PlanStore
    @State var isDetail:Bool
    var title:String
    @State var plans: [Category: [AnyPlan]] = [:]

    init(isDetail:Bool){
        self.isDetail = isDetail
        self.title = isDetail ? "세부 계획" : "간단 계획"
        
    }
    
    
    var body: some View {
        
        
        return VStack(alignment: .center){
            
            titleView
            // 카테고리 전시 및 편집
            CategoryView(isDetail: $isDetail, categories: $planStore.categories)
            // 계획 뷰
            ForEach(planStore.categories) { category in
                if let categoryPlans = plans[category] {
                    ForEach(categoryPlans) { anyPlan in
                        PlanView(plan: anyPlan, category: category)
                    }
                }
            }
            // 계획 추가 뷰
            AddPlan()
            Spacer()
            
            
        }
        .frame(maxWidth: 350, minHeight: 250 , alignment: .leading)
        .background(.lightBlue)
        .cornerRadius(30)
        .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
        .padding(.bottom, 30)
        .onAppear {
            print("loadPlans 실행")
            print("\(self.plans)")
            print("\(self.planStore.categories)")
            
            loadPlans()
        }
    }
    
    private func loadPlans() {
        if isDetail {
            self.plans = planStore.detailPlans.mapValues { $0.map { AnyPlan.detailPlan($0) } }
        } else {
            self.plans = planStore.plans.mapValues { $0.map { AnyPlan.plan($0) } }
        }
    }
    
    
}

private extension PlanDescription{
    var titleView : some View {
        Text(self.title)
            .font(.title)
            .bold()
            .padding(.top,10)
            .padding(.leading, 20)
            .frame(maxWidth: .infinity,alignment:.leading)
    }
}
#Preview {
    PlanDescription(isDetail: true)
        .environmentObject(PlanStore())
    
}

