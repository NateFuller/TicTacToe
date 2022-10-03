//
//  GameGridView.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/3/22.
//

import SwiftUI

struct GameGridView: View {
    var viewModel: GameViewModel
    var squareTapHandler: ((row: Int, col: Int)) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.squares, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id: \.self) { square in
                        SquareView(viewModel: square, tapHandler: squareTapHandler)
                    }
                }
            }
        }
        .padding()
    }
}
