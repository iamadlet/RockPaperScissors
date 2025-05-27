import SwiftUI

struct GameModeLink: View {
    
    //MARK: - Properties
    let link: AnyView
    let text: String
    
    //MARK: - Body
    var body: some View {
        NavigationLink(destination: link) {
            Text(text)
                .frame(width: 358, height: 50)
                .foregroundStyle(Color.white)
                .background(Color.customPurple)
                .cornerRadius(8)
        }
    }
}
