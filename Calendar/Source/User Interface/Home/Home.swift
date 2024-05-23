//
//  Home.swift
//  Calendar
//
//  Created by 박정용 on 5/23/24.
//

import SwiftUI
import SwiftData

struct Home: View {

    var body: some View {

        ScrollView(.vertical){
            
            VStack(alignment: .leading){
                homeTitle
                // 간단 계획 뷰
                PlanDescription(isDetail: false)
                
                // 세부 계획
                PlanDescription(isDetail: true)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundBlue)
        
    }
        
        

    
    
}

private extension Home{
    var homeTitle: some View {
        VStack{
            Text("오늘")
                .font(.largeTitle)
                .padding(.leading,10)
            
            Text("24.05.10")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.leading,10)
                .padding(.bottom, 40)
        }
        
    }
}

#Preview {
    Home()
}
