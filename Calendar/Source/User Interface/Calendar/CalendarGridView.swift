
import SwiftUI


// CalendarGridView: 실제 달력 그리드를 생성하는 뷰
struct CalendarGridView: View {
    @Binding var selectedDate: Date // 선택된 날짜를 나타내는 Binding 변수
    @EnvironmentObject var planStore: PlanStore // PlanStore를 환경 객체로 사용
    
    private let calendar = Calendar.current // 현재 달력 객체
    private let dateFormatter: DateFormatter = { // 날짜 포맷터
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                WeekdaysHeaderView()
                
                ForEach(calendarGrid(), id: \.self) { week in
                    HStack(alignment: .top) {
                        ForEach(week, id: \.self) { day in
                            DayView(day: day, plans: getPlans(for: day), dateFormatter: dateFormatter)
                        }
                    }
                }
            }
            .frame(minWidth: 300, minHeight: 650)
            .padding(.horizontal)
        }
    }
    
    // 달력 그리드 생성
    private func calendarGrid() -> [[Date]] {
        let startDate = calendar.startOfDay(for: selectedDate) // 선택된 날짜의 시작일
        let month = calendar.component(.month, from: startDate) // 선택된 달
        let year = calendar.component(.year, from: startDate) // 선택된 연도
        
        var grid: [[Date]] = [] // 그리드 배열
        var week: [Date] = [] // 주 배열
        
        let startOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))! // 해당 달의 시작일
        let weekday = calendar.component(.weekday, from: startOfMonth) // 시작일의 요일
        let firstDate = calendar.date(byAdding: .day, value: -weekday + 1, to: startOfMonth)! // 첫 주의 시작일
        let endDate = calendar.date(byAdding: .month, value: 1, to: startOfMonth)! // 해당 달의 마지막 일
        
        var currentDate = firstDate // 현재 날짜
        
        // 달력 그리드 배열 생성
        while currentDate < endDate {
            if calendar.component(.weekday, from: currentDate) == 1 && !week.isEmpty {
                grid.append(week)
                week = []
            }
            week.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        grid.append(week)
        
        return grid
    }
    
    // 해당 날짜의 일정을 반환
    private func getPlans(for date: Date) -> [Category: [AnyPlan]] {
        return planStore.getAllPlans(for: date)
    }
}

#Preview {
    CalendarGridView(selectedDate: .constant(Date()))
        .environmentObject(PlanStore()) // PlanStore를 환경 객체로 전달
}
