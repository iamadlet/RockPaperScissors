import Foundation

class GameManager: ObservableObject {
    
    //MARK: - Properties
    @Published var firstScore: Int
    @Published var secondScore: Int
    
    @Published var firstMove: Move = .notChosen
    @Published var secondMove: Move = .notChosen
    
    private var roundNumber: Int
    
    //MARK: - Initialization
    init() {
        self.firstScore = 0
        self.secondScore = 0
        self.roundNumber = 1
    }
    
    //MARK: - Methods
    func getResult(first: Move, second: Move) -> Int {
        switch (first, second) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            print("First player won")
            firstScore += 1
            return 1
        case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
            print("Second player won")
            secondScore += 1
            return 2
        default:
            print("It's a tie")
        }
        return 3 //MARK: - In case of a tie, 3 is returned
    }
    
    func isGameEnded() -> Bool {
        firstScore > 3 || secondScore > 3
    }
    
    func restartGame() {
        firstScore = 0
        secondScore = 0
    }
    
    //MARK: - Getter functions
    func getRoundNumber() -> Int {
        roundNumber
    }
    
    func getFirstMove() -> Move {
        firstMove
    }
    
    func getSecondMove() -> Move {
        secondMove
    }
    
    //MARK: - Another Round
    func anotherRound() {
        firstMove = .notChosen
        secondMove = .notChosen
        roundNumber += 1
    }
}
