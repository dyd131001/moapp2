//
//  PlanDescription.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct PlanDescription: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var planStore : PlanStore
    @Binding var selectedDate: Date
    @State var isDetail:Bool
    let plans: [Category: [AnyPlan]]
    var title:String
    var isPopup:Bool
    
    
    init(isDetail: Bool, selectedDate: Binding<Date>, plans: [Category: [AnyPlan]] , isPopup:Bool = false) {
        self._selectedDate = selectedDate
        self.isDetail = isDetail
        self.title = isDetail ? "세부 계획" : "간단 계획"
        if isPopup {
            self.title = "계획"
        }
        self.plans = plans
        self.isPopup = isPopup
    }
    
    
    var body: some View {
        
        
        return VStack(alignment: .center){
            
            if(isPopup){
                popupTitleView
            }
            else{
                titleView
            }
            // 카테고리 전시 및 편집
            CategoryView(isDetail: $isDetail, categories: $planStore.categories)
            // 계획 뷰
            ForEach(plans.keys.sorted(by: { $0.title < $1.title })) { category in
                ForEach(plans[category] ?? []) { anyPlan in
                    PlanView(plan: anyPlan, category: category)
                }
            }
            // 계획 추가 뷰
            AddPlan(isDetail: $isDetail)
            Spacer()
                .frame(maxWidth: 350, maxHeight: 100)
            
            
        }
        .frame(maxWidth: 350, minHeight: 250 , alignment: .leading)
        .background(.lightBlue)
        .cornerRadius(30)
        .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
        .padding(.bottom, 30)
        
        
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
    
    
    var popupTitleView : some View {
        
        HStack{
            Text(self.title)
                .font(.title)
                .bold()
                .padding(.top,10)
                .padding(.leading, 20)
            Spacer()
            Symbol("xmark.circle.fill")
                .padding(.trailing,20)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
        
        
        
    }
    
    
}

#Preview {
    PlanDescription(isDetail: true, selectedDate: .constant(Date()),plans: PlanStore().getAllPlans(for: Date()))
        .environmentObject(PlanStore())
}

