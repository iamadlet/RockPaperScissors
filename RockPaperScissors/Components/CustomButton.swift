import SwiftUI

struct CustomButton: View {
    
    //MARK: - Properties
    let text: String
    let onSelect: () -> Void
    
    //MARK: - Body
    var body: some View {
        Button(action: {
            onSelect()
        }, label: {
            Text(text)
                .frame(width: 358, height: 50)
                .foregroundStyle(Color.white)
                .background(Color.customPurple)
                .cornerRadius(8)
        })
    }
}

#Preview {
    CustomButton(text: "I changed my mind", onSelect: {})
}
