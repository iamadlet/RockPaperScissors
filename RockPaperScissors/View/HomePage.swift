import SwiftUI

struct HomePage: View {
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    CustomTitle(text: "Welcome to the game!", color: .white)
                    
                    Spacer()
                    
                    GameModeLink(link: AnyView(SinglePlayer()), text: "Single player")
                    
                    GameModeLink(link: AnyView(MultiPlayer()), text: "Multi player")
                    
                }
            }
        }
    }
}

#Preview {
    HomePage()
}


