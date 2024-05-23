//
//  AddPlan.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct AddPlan : View{
    var body: some View{
        
        HStack(alignment: .center){
            Image(systemName: "plus.circle.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 30,height: 30)
                .padding(.leading, 10)
            Text("to do")
                .foregroundColor(.gray)
            Spacer()
            
        }
        .frame(width: 300,height: 50 , alignment: .center)
        .background(.lightGray)
        .cornerRadius(30)
        .padding(.top,15)
        
    }
}

private extension AddPlan{
    
}



struct AddPlan_Preview: PreviewProvider {
    static var previews: some View {
        
        AddPlan()
    }
}
