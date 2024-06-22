//
//  Plan.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct PlanView: View {
    let plan: AnyPlan
    let category : Category
    @State private var isEditSymbolChecked = false
    @EnvironmentObject var planStore: PlanStore // PlanStore 주입
    @GestureState private var isLongPressing = false
    @State private var isShowingDeleteButton = false
    

    var body: some View {
        ZStack{
    
            switch plan {
            case .plan(let plan):
                planItem
            case .detailPlan(let detailPlan):
                    NavigationLink(destination: DetailPlanView(category: category, detailPlan: detailPlan)) {
                        planItem
                    }
                    .buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear {
            initializeCheckedState()
        }
        
        
    }
    
    
}


private extension PlanView{
    
    private func initializeCheckedState() {
            switch plan {
            case .plan(let plan):
                isEditSymbolChecked = plan.complete
            case .detailPlan(let detailPlan):
                isEditSymbolChecked = detailPlan.complete
            }
        }
    
    
    var planItem : some View {
        HStack(alignment: .center){
            planCategory
            if isEditSymbolChecked {
                planCheckContent
            } else {
                planContent
            }
            Spacer()
            if isEditSymbolChecked {
                editCheckSymbol
            } else {
                editSymbol
            }
        }
        .frame(width: 300,height: 50 , alignment: .center)
        .background(.lightGray)
        .cornerRadius(30)
        .padding(.top,15)
        .contextMenu {
            Button(action: {
                if case let .plan(plan) = plan {
                    planStore.deletePlan(plan, for: category)
                } else if case let .detailPlan(detailPlan) = plan {
                    planStore.deleteDetailPlan(detailPlan, for: category)
                }
            }) {
                Text("일정 제거")
                Symbol("trash")
            }
        }
    }
    
    var editSymbol : some View {
        Symbol("square",
               scale: .large ,color: .white)
        .padding(.trailing,15)
        .onTapGesture {
            isEditSymbolChecked.toggle()
            updateCompleteStatus()
        }
    }
    
    var editCheckSymbol : some View {
        Symbol("checkmark.square.fill",
               scale: .large ,color: .white)
        .padding(.trailing,15)
        .onTapGesture {
            isEditSymbolChecked.toggle()
            updateCompleteStatus()
        }
    }
    
    var planContent : some View {
        
        switch plan {
        case .plan(let plan):
            Text(plan.title)
                .foregroundColor(.black)
        case .detailPlan(let detailPlan):
            Text(detailPlan.title)
                .foregroundColor(.black)
        }
        
    }
    
    var planCheckContent : some View {
        
        switch plan {
        case .plan(let plan):
            Text(plan.title)
                .foregroundColor(.white)
        case .detailPlan(let detailPlan):
            Text(detailPlan.title)
                .foregroundColor(.white)
        }
        
    }
    
    var planCategory : some View {
        Text(category.title)
            .font(.custom("tag", size: 10))
            .padding(.horizontal,8)
            .padding(.vertical,8)
            .background(.pink)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding(.leading, 10)
            .onTapGesture {}
        
    }
    
    func updateCompleteStatus() {
        switch plan {
        case .plan(var plan):
            plan.complete = isEditSymbolChecked
            planStore.updatePlan(plan, for: category)
        case .detailPlan(var detailPlan):
            detailPlan.complete = isEditSymbolChecked
            planStore.updateDetailPlan(detailPlan, for: category)
        }
    }
    
}


struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCategory = Category(title: "취미", color: "red")
        let samplePlan = Plan(startDate: Date(), endDate: Date(), title: "모앱프")
        
        
        let sampleDetailPlan = DetailPlan(startDate: Date(), endDate: Date(), title: "모앱프 디테일", content: "상세 내용")
        
        return Group {
            PlanView(plan: .plan(samplePlan),
                     category: sampleCategory)
            PlanView(plan: .detailPlan(sampleDetailPlan),
                     category: sampleCategory)
        }
        
        .previewLayout(.sizeThatFits)
    }
}
