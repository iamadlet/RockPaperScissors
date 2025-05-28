import SwiftUI

struct SinglePlayer: View {
    
    //MARK: - Properties
    @StateObject var vm = GameManager()
    
    @State private var stage: GameStage = .picking
    @State private var selectedMove: Move? = nil
    @State private var roundResult: Int? = nil
    @State private var waitTask: Task<Void, Never>? = nil
    
    let moves: [Move] = [
        .paper,
        .scissors,
        .rock
    ]
    
    //MARK: - Body
    var body: some View {
        switch stage {
            
        //MARK: - "Picking the move" stage
        case .picking:
            VStack {
                CustomTitle(text: "Take your pick", color: .black)
                Text("Score \(vm.firstScore):\(vm.secondScore)")
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
                
                Text("Score \(vm.firstScore):\(vm.secondScore)")
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
            
        //MARK: - Loading of the Bot's move
        case .loading:
            VStack {
                CustomTitle(text: "Your opponent is thinking", color: .black)
                
                ProgressView()
                    .task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        stage = .botChose
                        vm.secondMove = vm.botMove(excluding: .notChosen)
                    }
                    .foregroundStyle(Color.customGray)
                    .frame(width: 342, height: 128)
            }
            
        //MARK: - Showing Bot's move
        case .botChose:
            VStack {
                CustomTitle(text: "Your opponent's pick", color: .black)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 48)
                    
                    Text(vm.secondMove.image)
                        .font(.system(size: 80))
                }
                .foregroundStyle(Color.customGray)
                .frame(width: 342, height: 128)
            }
            .task {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                roundResult = vm.getResult(first: selectedMove!, second: vm.secondMove)
                withAnimation(.default) {
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
                if vm.isGameEnded() {
                    vm.restartGame()
                }
            }
        }
    }
    
}

#Preview {
    SinglePlayer()
}




