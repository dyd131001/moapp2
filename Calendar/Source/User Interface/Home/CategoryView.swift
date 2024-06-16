//
//  CategoryView.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct CategoryView: View {

    @Binding var isDetail:Bool
    @Binding  var categories : [Category]
    @State private var showEditCategories: Bool = false
    
    var body: some View {
        HStack(alignment: .center){
            ScrollView(.horizontal){
                HStack{
                    planCategory
                }
            }
            .frame(width: 300,height: 22, alignment: .leading)
            .padding(.leading,10)
            Spacer()
            editSymbol
                .padding(.trailing,30)
            
        }
    }
    
    
}

private extension CategoryView{
    var editSymbol : some View {
        Symbol("pencil.line",
               scale: .medium ,color: .black)
        .onTapGesture {
                    showEditCategories = true
                }
                .sheet(isPresented: $showEditCategories) {
                    EditCategoriesView()
                        .clearModalBackground()
                    
                }
    }

    
    var planCategory : some View {
        ForEach(categories) { category in
            Text(category.title)
                .font(.custom("tag", size: 10))
                .padding(.horizontal,8)
                .padding(.vertical,5)
                .background(.pink)
                .foregroundColor(.white)
                .cornerRadius(20)
                .onTapGesture {
                        }

        }
    }
    
}






struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCategory = Category(title: "취미", color: "red")
        return CategoryView(isDetail: .constant(true), categories: .constant([sampleCategory]))
    }
}
