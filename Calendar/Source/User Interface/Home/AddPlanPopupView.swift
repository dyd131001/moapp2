//
//  AddPlanPopupView.swift
//  Calendar
//
//  Created by 박정용 on 6/16/24.
//

import SwiftUI

struct AddPlanPopupView: View {
    @EnvironmentObject var planStore: PlanStore
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedCategory: Category?
    @State private var planTitle: String = ""
    @State private var planDate: Date = Date()
    
    var body: some View {
        VStack {
            addPlanTitle // 카테고리 편집 제목
            Spacer()
            categoryList // 카테고리 목록
            planAddView // 새 카테고리 추가
            Spacer()
        }
        .frame(width: 350, height: 190)
        .background(.lightBlue)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    private func selectCategory(_ category: Category) {
            if selectedCategory == category {
                selectedCategory = nil // 이미 선택된 카테고리를 다시 탭하면 선택 해제
            } else {
                selectedCategory = category
            }
        }
    
    private func addPlan() {
        guard let selectedCategory = selectedCategory else {
                    // 선택된 카테고리가 없을 경우 처리
                    return
                }
        
        let newPlan = Plan(startDate: planDate, endDate: planDate, title: planTitle)
                planStore.addPlan(newPlan, to: selectedCategory)
                presentationMode.wrappedValue.dismiss()
    }
    
    // 카테고리 편집 제목
    private var addPlanTitle: some View {
        HStack{
            Spacer()
            Text("계획 추가")
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .padding(.leading,20)
            Spacer()
            Symbol("xmark.circle.fill")
                .padding(.trailing,20)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
    
    // 카테고리 목록
    private var categoryList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(planStore.categories) { category in
                    PlanItemView(category: category, isSelected: category == selectedCategory, onSelect: selectCategory)
                     
                }
            }
            .padding(.leading,10)
        }
    }
    
    // 새 카테고리 추가
    private var planAddView: some View {
        HStack {
            TextField("간단한 계획을 적어주세요", text: $planTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
                .padding(.leading, 10)
            
            
            Text("추가")
                .foregroundColor(.white)
                .padding(.horizontal,10)
                .padding(.vertical,5)
                .background(Color.blue)
                .cornerRadius(10)
                .onTapGesture {
                    addPlan()
                }
            
        }
        .frame(height: 44)
    }
}

struct PlanItemView: View {
    let category: Category
    let isSelected: Bool
    let onSelect: (Category) -> Void
   
    
    var body: some View {
        VStack {
            Text(category.title)
                            .padding()
                            .background(isSelected ? Color.green : Color.pink)
                            .cornerRadius(10)
                            .onTapGesture {
                                onSelect(category)
                            }
            
        }
    }
}


#Preview {
    AddPlanPopupView()
        .environmentObject(PlanStore())
}
