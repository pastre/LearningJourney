import SwiftUI

struct LearningGoalCard: View {
    
    private enum Layout {
        static let backgroundColor = Color("CardBackground") // TODO swiftgen
    }
    
    let goal: LearningGoal
    
    var body: some View {
        VStack {
            progressChart
            Text(goal.name)
                .fontWeight(.semibold)
                .font(.headline)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .padding(.top)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Layout.backgroundColor)
        .cornerRadius(14)
        .aspectRatio(1, contentMode: .fill)
        .frame(height: 200) // TODO Check responsivity
    }
    
    private var progressChart: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.4)
                .foregroundColor(.white)
            
            Circle()
                .trim(from: 0, to: CGFloat(goal.progress))
                .stroke(style: .init(
                    lineWidth: 8,
                    lineCap: .round,
                    lineJoin: .round
                ))
                .rotation(
                    Angle(radians: 3 * .pi / 2))
                .fill(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "A259FF"),
                        Color(hex: "09F9BF")]),
                    startPoint: .bottomTrailing,
                    endPoint: .topLeading
                ))
            Group {
                Text("\(Int(goal.progress * 100))")
                    .bold()
                    .font(.system(size: 18)) +
                Text("%")
                    .bold()
                    .font(.system(size: 10))
            }
            .padding(24)
        }
    }
    
    private var formattedProgress: String {
        let percentage = Int(goal.progress * 100)
        return String("\(percentage)%")
    }
}

#if DEBUG
struct LearningGoalCard_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView(
            viewModel: DummyViewModel(),
            routingService: DummyRoutingService(),
            notificationCenter: NotificationCenter.default)
    }
    
    final class DummyViewModel: LibraryViewModelProtocol {
        var strands1: LibraryViewModelState<[LearningStrand]> = .result([
            .fixture(goals: [
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
            ]),
            .fixture(goals: [
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
            ]),
            .fixture(goals: [
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
            ]),
            .fixture(goals: [
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
                .fixture(name: UUID().uuidString),
            ]),
        ])
        var strands: LibraryViewModelState<[LearningStrand]> = .result(.init(
            repeating: .fixture(goals: .init(
                repeating: .fixture(),
                count: 10)),
            count: 10
        ))
        
        var searchQuery: String = ""
        
        func handleOnAppear() {}
        
        func handleUserDidChange() {}
        
        func handleSignout() {}
    }
}
#endif

extension Color { // TODO This should be moved to the proper place
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
