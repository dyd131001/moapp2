//
//  Home.swift
//  Calendar
//
//  Created by 박정용 on 5/23/24.
//

import SwiftUI
import SwiftData

struct Home: View {
    @EnvironmentObject var planStore: PlanStore
    @State private var selectedDate: Date = Date() // 선택된 날짜를 나타내는 State 변수
    private let calendar = Calendar.current
    @State private var showEditCategories: Bool = false

    
    var body: some View {
        VStack{
            homeTitle
            
            ScrollView(.vertical){
                
                VStack(alignment: .leading){
                    
                    // 간단 계획 뷰
                    PlanDescription(isDetail: false , selectedDate: $selectedDate, plans: loadPlans(for: selectedDate))
                    
                    // 세부 계획
                    PlanDescription(isDetail: true,
                                    selectedDate: $selectedDate,
                                    plans: loadDetailPlans(for: selectedDate)
                    )
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .background(.backgroundBlue)
        
    }
    
    
    
    
    
}

private extension Home{
    private func loadPlans(for date: Date) -> [Category: [AnyPlan]] {
        
        return planStore.getPlans(for: date)
        
        
    }
    private func loadDetailPlans(for date: Date) -> [Category: [AnyPlan]] {
        
        return planStore.getDetailPlans(for: date)
        
        
    }
    
    
    var homeTitle: some View {
        HStack {
            Spacer()
            leftSymbol
            Text(currentDateString()) // 현재 날짜의 연월 표시
                .font(.title2)
                .bold()
            rightSymbol
            Spacer()
        }
        .padding(.bottom,20)
        
    }
    
    func currentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: selectedDate)
    }
    
    
    var leftSymbol : some View {
        Symbol("chevron.left",
               scale: .medium ,color: .primary)
        .onTapGesture {
            changeDay(by: -1)
        }
        
    }
    
    var rightSymbol : some View {
        Symbol("chevron.right",
               scale: .medium ,color: .primary)
        .onTapGesture {
            changeDay(by: 1)
        }
        
    }
    
    private func changeDay(by value: Int) {
        if let newDate = calendar.date(byAdding: .day, value: value, to: selectedDate) {
            selectedDate = newDate
        }
    }
}

#Preview {
    Home()
        .environmentObject(PlanStore())
}
