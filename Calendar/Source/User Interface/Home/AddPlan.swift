//
//  AddPlan.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct AddPlan : View{
    @State private var showingAddPlanSheet = false
    
    
    var body: some View{
        
        HStack(alignment: .center){
            plusSymbol
            plusText
            Spacer()
            
        }
        .frame(width: 300,height: 50 , alignment: .center)
        .background(.lightGray)
        .cornerRadius(30)
        .padding(.top,15)
        .onTapGesture {
                    showingAddPlanSheet = true
                }
                .sheet(isPresented: $showingAddPlanSheet) {
                    AddPlanSheetView()
                }
        
    }
}

private extension AddPlan{
    var plusSymbol : some View {
        Symbol("plus.circle.fill",
               scale: .large ,color: .white)
        .padding(.leading, 10)
    }
    
    var plusText : some View {
        Text("to do")
            .foregroundColor(.gray)
    }
    
}



struct AddPlan_Preview: PreviewProvider {
    static var previews: some View {
        
        AddPlan()
    }
}
