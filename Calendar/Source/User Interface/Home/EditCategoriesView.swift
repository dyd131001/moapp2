//  EditCategoriesView.swift
//  Calendar
//
//  Created by 박정용 on 5/31/24.
//
import SwiftUI

struct EditCategoriesView: View {
    @EnvironmentObject var planStore: PlanStore
    @Environment(\.presentationMode) var presentationMode
    @State private var newCategoryTitle: String = ""
    @State private var newCategoryColor: String = "pink" // 기본 색상
    
    var body: some View {
        VStack {
            categoryTitle // 카테고리 편집 제목
            Spacer()
            categoryList // 카테고리 목록
            categoryAdd // 새 카테고리 추가
            Spacer()
        }
        .frame(width: 350, height: 190)
        .background(.lightBlue)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    private func deleteCategory(_ category: Category) {
        planStore.categories.removeAll { $0.id == category.id }
        planStore.saveCategories()
    }
    
    private func addCategory() {
        let newCategory = Category(title: newCategoryTitle, color: newCategoryColor)
        planStore.categories.append(newCategory)
        planStore.saveCategories()
    }
    
    // 카테고리 편집 제목
    private var categoryTitle: some View {
        HStack{
            Spacer()
            Text("카테고리 편집")
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
                    CategoryItemView(category: category, onDelete: deleteCategory)
                }
            }
            .padding(.leading,10)
        }
    }
    
    // 새 카테고리 추가
    private var categoryAdd: some View {
        HStack {
            TextField("새 카테고리 이름", text: $newCategoryTitle)
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
                    addCategory()
                }
            
        }
        .frame(height: 44)
    }
}

struct CategoryItemView: View {
    let category: Category
    let onDelete: (Category) -> Void
    
    var body: some View {
        VStack {
            Text(category.title)
                .padding()
                .background(Color.pink)
                .cornerRadius(10)
                .contextMenu {
                    Button(action: { onDelete(category) }) {
                        Text("카테고리 제거")
                        Symbol("trash")
                    }
                }
        }
    }
}


struct EditCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        EditCategoriesView()
            .environmentObject(PlanStore())
    }
}
