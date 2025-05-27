import SwiftUI

struct CustomTitle: View {
    
    //MARK: - Properties
    let text: String
    let color: Color
    
    //MARK: - Body
    var body: some View {
        Text(text)
            .frame(width: 358)
            .multilineTextAlignment(.center)
            .font(.system(size: 54))
            .fontWeight(.bold)
            .foregroundStyle(color)
            .padding(.top, 50)
    }
}
