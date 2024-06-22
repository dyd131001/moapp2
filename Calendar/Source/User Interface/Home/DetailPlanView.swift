//
//  DetailPlanView.swift
//  Calendar
//
//  Created by 박정용 on 6/16/24.
//

import SwiftUI

//템플릿에 맞도록 수정
struct DetailPlanView: View {
    let category: Category
    let detailPlan:DetailPlan
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                HStack(alignment: .center){
                    Text("제목:")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                 
                    Text(detailPlan.title)
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                }
                .frame(maxWidth: 300, minHeight: 50, alignment: .leading)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
                .padding(.top, 20)
                .padding(.leading, 25)
                
                
                VStack(alignment: .leading){
                    HStack(alignment: .center){
                        Text("To do:")
                            .font(.headline)
                            .foregroundColor(.gray)
                            
                        
                        Text(detailPlan.content)
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                    }
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    
                    
                    Spacer()
                
                }
                .frame(maxWidth: 300, maxHeight: 500, alignment: .leading)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
                .padding(.top, 20)
                .padding(.leading, 25)
                
                Spacer()
              
            }
            .frame(maxWidth: 350, maxHeight: 630, alignment: .leading)
            .background(Color.backgroundBlue)
            .cornerRadius(30)
            .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
            
            Spacer()
        }
        .background(Color.white)
    }
}

struct DetailPlanView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCategory = Category(title: "취미", color: "red")

        
        let sampleDetailPlan = DetailPlan(startDate: Date(), endDate: Date(), title: "모앱프 디테일", content: "상세 내용")
        
        return DetailPlanView(category: sampleCategory, detailPlan: sampleDetailPlan)
    }
}
