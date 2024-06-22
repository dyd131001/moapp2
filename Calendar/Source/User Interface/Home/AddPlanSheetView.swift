//
//  AddPlanSheetView.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct AddPlanSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var planStore: PlanStore
    
    @State private var selectedCategory: Category?
    @State private var planTitle: String = ""
    @State private var planDescription: String = ""
    @State private var planDate: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("카테고리")) {
                    Picker("카테고리를 선택하세요", selection: $selectedCategory) {
                        ForEach(planStore.categories, id: \.self) { category in
                            Text(category.title).tag(category as Category?)
                        }
                    }
                }

                Section(header: Text("상세 계획")) {
                    TextField("제목", text: $planTitle)
                    TextField("내용", text: $planDescription)
                    DatePicker("날짜", selection: $planDate, displayedComponents: .date)
                }
            }
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                if let selectedCategory = selectedCategory {
                    let newPlan = DetailPlan(startDate: planDate, endDate: planDate, title: planTitle,
                        content: planDescription
                    )
                    
                    planStore.addDetailPlan(newPlan, to: selectedCategory)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddPlanSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlanSheetView().environmentObject(PlanStore())
    }
}
