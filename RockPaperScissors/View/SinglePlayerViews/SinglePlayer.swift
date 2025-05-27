import SwiftUI

struct SinglePlayer: View {
    
    //MARK: - Properties
    @StateObject var vm = GameManager()
    
    @State private var selectedMove: Move? = nil
    
    let moves: [Move] = [
        .paper,
        .scissors,
        .rock
    ]
    
    //MARK: - Body
    var body: some View {
        VStack {
            
            if selectedMove == nil {
                CustomTitle(text: "Take your pick", color: .black)
                
                Text("Score \(vm.firstScore)):\(vm.secondScore)")
                    .foregroundStyle(Color.customPurple)
                    .padding(.bottom, 74)
                
                PickMoveButton(gameManager: vm, move: .paper) {
                    selectedMove = .paper
                }
                
                PickMoveButton(gameManager: vm, move: .rock) {
                    selectedMove = .rock
                }
                
                PickMoveButton(gameManager: vm, move: .scissors) {
                    selectedMove = .scissors
                }
                
            } else {
                CustomTitle(text: "Your pick", color: .black)
                
                Text("Score \(vm.firstScore):\(vm.secondScore)")
                    .foregroundStyle(Color.customPurple)
                    .padding(.bottom, 74)
                
                Spacer()
                
                PickMoveButton(gameManager: vm, move: selectedMove!) {
                    selectedMove = selectedMove!
                }
                
                Spacer()
                
                CustomButton(text: "I changed my mind") {
                    selectedMove = nil
                }
            }
        }
        .animation(.bouncy)
        .navigationTitle("Round #\(vm.getRoundNumber())")
    }
    
}

#Preview {
    SinglePlayer()
}




