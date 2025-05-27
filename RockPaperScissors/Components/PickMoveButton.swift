import SwiftUI

struct PickMoveButton: View {
    
    //MARK: - Properties
    @ObservedObject var gameManager: GameManager
    let move: Move
    
    //MARK: - Body
    var body: some View {
        Button(action: {
            
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 48)
                
                Text(move.image)
                    .font(.system(size: 80))
            }
            .foregroundStyle(Color.customGray)
            .frame(width: 342, height: 128)
        })
    }
}

#Preview {
    PickMoveButton(gameManager: GameManager(), move: .paper)
}
