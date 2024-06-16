//
//  mainTabView.swift
//  Calendar
//
//  Created by 박정용 on 5/23/24.
//
import SwiftUI
import SwiftData


struct MainTabView: View {
    
    private enum Tabs {
        case home, calendar, myPage // 4개의 탭 정의. 탭 뷰의 태그로 활용
    }
    
    @State private var selectedTab: Tabs = .home // 기본값 home
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                home
                calendar
//                myPage
            }
            .accentColor(.toolBarBlue)
        }
        .accentColor(.white)
        .edgesIgnoringSafeArea(edges)

    }
    
    
}


fileprivate extension View {
    func tabItem(image: String, text: String) -> some View {
        self.tabItem {
            Symbol(image, scale: .large)
                .font(Font.system(size: 17, weight: .light))
            Text(text)
        }
    }
}
    
    
private extension MainTabView {
    var home: some View {
        Home()
            .tag(Tabs.home)
            .tabItem(image: "house", text: "홈")
            .onAppear { UITableView.appearance().separatorStyle = .none }
    }
    var calendar: some View {
        CalendarView()
            .tag(Tabs.calendar)
            .tabItem(image: "calendar", text: "캘린더")
            .onAppear { UITableView.appearance().separatorStyle = .none }
    }
    
//    var myPage: some View {
//        Text("마이페이지") // 임시 화면
//            .tag(Tabs.myPage)
//            .tabItem(image: "person", text: "마이페이지")
//    }
    var edges: Edge.Set {
        if #available(iOS 13.4, *) {
            return .init() // create an empty option set
        } else {
            return .top
        }
        
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .accentColor(.toolBarBlue)
            .environmentObject(PlanStore())
    }
}
