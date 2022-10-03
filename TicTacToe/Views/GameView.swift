//
//  GameView.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/3/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        VStack {
            HStack {
                switch game.gameState {
                case .inProgress:
                    Text("Current Player:")
                        .foregroundColor(Color("text"))
                        .font(.title2)
                    Text(game.currentPlayer == .player1 ? "❌" : "⭕️")
                        .font(.largeTitle)
                case .stalemate:
                    Text("Stalemate!").font(.title2).foregroundColor(Color("text"))
                case .gameOver:
                    Text("Winner:").font(.title2).foregroundColor(Color("text"))
                    Text(game.currentPlayer == .player1 ? "❌" : "⭕️")
                        .font(.largeTitle)
                }
            }
            .frame(minHeight: 80)
            GameGridView(viewModel: GameViewModel(game: game), squareTapHandler: { (row: Int, col: Int) in
                game.didTapSquare(at: (row: row, col: col))
            })
            Button(action: {
                game.newGame()
            }) {
                Text("NEW GAME")
                    .foregroundColor(.white)
                    .padding()
                    .fontWeight(.semibold)
            }
            .background(Color("background.button"))
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
    }
}
