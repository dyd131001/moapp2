import SwiftUI

// CalendarView: SwiftUI에서 달력을 표시하는 뷰
struct CalendarView: View {
    @State private var selectedDate: Date = Date() // 선택된 날짜를 나타내는 State 변수
    @EnvironmentObject private var planStore:PlanStore
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("2024년 6월")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                Spacer()
                
                CalendarGridView(selectedDate: $selectedDate)
                    .environmentObject(planStore) // PlanStore를 환경 객체로 전달
            }
            .frame(maxWidth: 350, minHeight: 700, alignment: .leading)
            .background(.white)
            .cornerRadius(30)
            .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundBlue)
    }
}

#Preview {
    CalendarView()
        .environmentObject(PlanStore())
}
