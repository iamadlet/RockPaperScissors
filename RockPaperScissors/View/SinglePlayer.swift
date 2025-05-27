import SwiftUI

struct SinglePlayer: View {
    
    //MARK: - Properties
    @StateObject var vm = GameManager()
    
    let moves: [Move] = [
        .paper,
        .scissors,
        .rock
    ]
    
    //MARK: - Body
    var body: some View {
        VStack {
            CustomTitle(text: "Take your pick", color: .black)
            
            Text("Score \(vm.getFirstScore()):\(vm.getSecondScore())")
                .foregroundStyle(Color.customPurple)
            
            PickMoveButton(gameManamove: .paper)
        }
        .navigationTitle("Round #\(vm.getRoundNumber())")
    }
    
}

#Preview {
    SinglePlayer()
}


