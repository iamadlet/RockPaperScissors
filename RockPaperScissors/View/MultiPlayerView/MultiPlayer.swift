import SwiftUI

struct MultiPlayer: View {
    
    //MARK: - Properties
    @StateObject var vm = GameManager()
    
    @State private var stage: GameStage = .picking
    @State private var selectedMove: Move? = nil
    @State private var roundResult: Int? = nil
    @State private var waitTask: Task<Void, Never>? = nil
    var body: some View {
        switch stage {
            
        //MARK: - "Picking the move" stage
        case .picking:
            VStack {
                CustomTitle(text: "Take your pick", color: .black)
                Text("Player 1 • Score \(vm.firstScore):\(vm.secondScore)")
                    .foregroundStyle(Color.customPurple)
                    .padding(.bottom, 74)
                
                PickMoveButton(gameManager: vm, move: .paper) {
                    selectedMove = .paper
                    stage = .waiting
                }
                
                PickMoveButton(gameManager: vm, move: .rock) {
                    selectedMove = .rock
                    stage = .waiting
                }
                
                PickMoveButton(gameManager: vm, move: .scissors) {
                    selectedMove = .scissors
                    stage = .waiting
                }
            }
            
        //MARK: - Waiting stage, some time for changing the move
        case .waiting:
            VStack {
                CustomTitle(text: "Your pick", color: .black)
                
                Text("Player 1 • Score \(vm.firstScore):\(vm.secondScore)")
                    .foregroundStyle(Color.customPurple)
                    .padding(.bottom, 74)
                
                Spacer()
                
                PickMoveButton(gameManager: vm, move: selectedMove!) {
                    selectedMove = selectedMove!
                }
                .task {
                    let task = Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        if !Task.isCancelled {
                            stage = .loading
                        }
                    }
                    waitTask = task
                }
                
                Spacer()
                
                CustomButton(text: "I changed my mind") {
                    waitTask?.cancel()
                    waitTask = nil
                    selectedMove = nil
                    stage = .picking
                }
            }
            
        //MARK: - Ready to pass the phone to the Second player
        case .loading:
            VStack {
                CustomTitle(text: "Pass the phone to your opponent", color: .black)
                
                Spacer()
                
                CustomButton(text: "Ready to continue") {
                    stage = .botChose
                }
            }
            
        //MARK: - Second Player picking the move stage
        case .botChose:
            VStack {
                CustomTitle(text: "Your pick", color: .black)
                
                Text("Player 2 • Score \(vm.firstScore):\(vm.secondScore)")
                    .foregroundStyle(Color.customPurple)
                    .padding(.bottom, 74)
                
                PickMoveButton(gameManager: vm, move: .paper) {
                    vm.secondMove = .paper
                    stage = .result
                }
                
                PickMoveButton(gameManager: vm, move: .rock) {
                    vm.secondMove = .rock
                    stage = .result
                }
                
                PickMoveButton(gameManager: vm, move: .scissors) {
                    vm.secondMove = .scissors
                    stage = .result
                }
            }
            
        //MARK: - Showing the results (win/lose/tie)
        case .result:
            VStack {
                switch roundResult {
                case 1:
                    CustomTitle(text: "Win!", color: Color.customGreen)
                case 2:
                    CustomTitle(text: "Lose", color: Color.customRed)
                case 3:
                    CustomTitle(text: "Tie", color: Color.customYellow)
                default:
                    Text("Error")
                }
                
                Text("Score \(vm.firstScore):\(vm.secondScore)")
                    .foregroundStyle(Color.customPurple)
                    .padding(.bottom, 74)
                
                
                ResultView(firstMove: selectedMove!, secondMove: vm.secondMove)
                
                Spacer()
                
                CustomButton(text: "Another round") {
                    vm.anotherRound()
                    stage = .picking
                }
            }
            .task {
                roundResult = vm.getResult(first: selectedMove!, second: vm.secondMove)
                withAnimation(.default) {
                    stage = .result
                }
                if vm.isGameEnded() {
                    vm.restartGame()
                }
            }
        }
    }
}

#Preview {
    MultiPlayer()
}
