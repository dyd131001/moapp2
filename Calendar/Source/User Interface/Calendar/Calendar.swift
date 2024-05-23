//
//  Calendar.swift
//  Calendar
//
//  Created by 박정용 on 5/23/24.
//

import SwiftUI

struct Calendar: View {
    var body: some View {

        ScrollView(.vertical){
            
            VStack(alignment: .leading){
                Text("2024년 3월")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)
                    .padding(.leading,20)
                HStack(alignment: .top){
                    Spacer()
                    Text("일")
                    Spacer()
                    Text("월")
                    Spacer()
                    Text("화")
                    Spacer()
                    Text("수")
                    Spacer()
                    Text("목")
                    Spacer()
                    Text("금")
                    Spacer()
                    Text("토")
                    Spacer()
                }
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 5)
                
                HStack(alignment: .top){
                    Spacer()
                    Text("1")
                    Spacer()
                    Text("2")
                    Spacer()
                    Text("3")
                    Spacer()
                    Text("4")
                    Spacer()
                    Text("5")
                    Spacer()
                    Text("6")
                    Spacer()
                    Text("7")
                    Spacer()
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                Spacer()
                
                
                Spacer()
                

            }
            .frame(maxWidth: 350, minHeight: 700 , alignment: .leading)
            .background(.white)
            .cornerRadius(30)
            .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundBlue)

        
        
    }
}

#Preview {
    Calendar()
}
