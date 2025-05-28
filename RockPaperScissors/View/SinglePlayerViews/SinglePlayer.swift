import SwiftUI

struct SinglePlayer: View {
    
    //MARK: - Properties
    @StateObject var vm = GameManager()
    
    @State private var stage: GameStage = .picking
    @State private var selectedMove: Move? = nil
    @State private var roundResult: Int? = nil
    
    
    let moves: [Move] = [
        .paper,
        .scissors,
        .rock
    ]
    
    //MARK: - Body
    var body: some View {
        switch stage {
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
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    stage = .loading
                }

                Spacer()

                CustomButton(text: "I changed my mind") {
                    selectedMove = nil
                    stage = .picking
                }
            }

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
                stage = .result
            }
            
        case .result:
            VStack {
                switch roundResult {
                case 1:
                    Text("Win")
                case 2:
                    Text("Lose")
                case 3:
                    Text("Tie")
                default:
                    Text("Error")
                }
                
                
                CustomButton(text: "Another round") {
                    vm.anotherRound()
                    stage = .picking
                }
            }
        }
    }
    
}

#Preview {
    SinglePlayer()
}




