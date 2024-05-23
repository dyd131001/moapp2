//
//  CategoryView.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import SwiftUI

struct CategoryView: View {
    
    var body: some View {
        HStack(alignment: .center){
            ScrollView(.horizontal){
                Button(action: {
                    //to do
                }) {
                    Text("취미")
                        .font(.custom("tag", size: 10))
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .background(.pink)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.leading,10)
            }
            .frame(width: 300,height: 22, alignment: .leading)
            
            
            Spacer()
            Button(action: {
                //to do
            }){
                Image(systemName: "pencil.line")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.black)
            }
            .padding(.trailing, 20)
            
        }
    }
}

#Preview {
    CategoryView()
}
