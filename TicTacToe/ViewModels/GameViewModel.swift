//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/3/22.
//

import Foundation

struct GameViewModel {
    var squares: [[SquareViewModel]] = []
    
    init(game: Game) {
        for row in 0 ..< game.size {
            for col in 0 ..< game.size {
                if squares.count == row {
                    squares.append([])
                }
                
                let viewModel = SquareViewModel(square: game.grid[row][col])
                squares[row].append(viewModel)
            }
        }
    }
}
