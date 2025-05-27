import Foundation

enum Move {
    case rock
    case paper
    case scissors
    case notChosen
    
    var image: String {
        switch self {
        case .rock:
            return "🗿"
        case .paper:
            return "🧻"
        case .scissors:
            return "✂️"
        case .notChosen:
            return ""
        }
    }
}
