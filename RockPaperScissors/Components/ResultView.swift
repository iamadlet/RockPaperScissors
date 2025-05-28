//
//  ResultView.swift
//  RockPaperScissors
//
//  Created by Адлет Жумагалиев on 28.05.2025.
//

import SwiftUI

struct ResultView: View {
    let firstMove: Move
    let secondMove: Move
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 48)
            
            Text(firstMove.image)
                .font(.system(size: 80))
            
            ZStack {
                RoundedRectangle(cornerRadius: 48)
                //                .stroke(lineWidth: 10)
                    .stroke(.white, lineWidth: 20)
                    .fill(Color.customGray)
                
                Text(secondMove.image)
                    .font(.system(size: 80))
            }
            .offset(x: 152, y: 80)
        }
        .offset(x: -75)
        .foregroundStyle(Color.customGray)
        .frame(width: 198, height: 128)
    }
}

#Preview {
    ResultView(firstMove: .paper, secondMove: .rock)
}
