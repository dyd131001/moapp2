//
//  PlanDescription.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct PlanDescription: View {
    var isDetail:Bool
    var title:String
    
    init(isDetail:Bool){
        self.isDetail = isDetail
        self.title = isDetail ? "세부 계획" : "간단 계획"
    }
    
    var body: some View {

        return VStack(alignment: .center){
            
            Text(self.title)
                .font(.title)
                .bold()
                .padding(.top,10)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity,alignment:.leading)
            // 카테고리 전시 및 편집
            CategoryView()
            // 계획 뷰
            PlanView()
            // 계획 추가 뷰
            AddPlan()
            Spacer()
            
            
        }
        .frame(maxWidth: 350, minHeight: 250 , alignment: .leading)
        .background(.lightBlue)
        .cornerRadius(30)
        .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
        .padding(.bottom, 30)
    }
}

#Preview {
    PlanDescription(isDetail: true)
}
