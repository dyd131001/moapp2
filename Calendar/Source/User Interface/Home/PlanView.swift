//
//  Plan.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct PlanView: View {
    var body: some View {
        // 계획 뷰
        HStack(alignment: .center){
            Text("취미")
                .font(.custom("tag", size: 10))
                .padding(.horizontal,8)
                .padding(.vertical,8)
                .background(.pink)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.leading, 10)
            
            Text("모앱프 과제")
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .padding(.trailing,15)
            
        }
        .frame(width: 300,height: 50 , alignment: .center)
        .background(.lightGray)
        .cornerRadius(30)
        .padding(.top,15)
    }
}

#Preview {
    PlanView()
}
