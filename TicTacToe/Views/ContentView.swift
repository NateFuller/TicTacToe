//
//  ContentView.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                ZStack(alignment: .leading) {
                    Color("header")
                        .ignoresSafeArea()
                    Text("Tic Tac Toe")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 38)
                Spacer()
                GameView(game: Game())
                    .padding()
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
    }
}
