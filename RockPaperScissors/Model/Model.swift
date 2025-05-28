import Foundation

enum Move: CaseIterable {
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
            return "nothing"
        }
    }
}


enum GameStage {
    case picking
    case waiting
    case loading
    case botChose
    case result
}
