import SwiftUI

// CalendarView: SwiftUI에서 달력을 표시하는 뷰
struct CalendarView: View {
    @State private var selectedDate: Date = Date() // 선택된 날짜를 나타내는 State 변수
    @EnvironmentObject private var planStore: PlanStore
    
    private let calendar = Calendar.current // 현재 달력 객체
    private let dateFormatter: DateFormatter = { // 날짜 포맷터
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    leftSymbol
                    Spacer()
                    Text(dateFormatter.string(from: selectedDate)) // 현재 날짜의 연월 표시
                        .font(.title2)
                        .bold()
                    Spacer()
                    rightSymbol
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                CalendarGridView(selectedDate: $selectedDate)
                    .environmentObject(planStore) // PlanStore를 환경 객체로 전달
            }
            .frame(maxWidth: 350, minHeight: 700, alignment: .leading)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.primary.opacity(0.1), radius: 1, x: 2, y: 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundBlue)
    }
    
    var leftSymbol : some View {
        Symbol("chevron.left",
               scale: .medium ,color: .primary)
        .onTapGesture {
            changeMonth(by: -1)
        }

    }
    
    var rightSymbol : some View {
        Symbol("chevron.right",
               scale: .medium ,color: .primary)
        .onTapGesture {
            changeMonth(by: 1)
        }

    }
    
    
    // 월을 변경하는 함수
    private func changeMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: selectedDate) {
            selectedDate = newDate
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(PlanStore())
}
