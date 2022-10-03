//
//  SquareViewModel.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/3/22.
//

import Foundation

struct SquareViewModel: Hashable {
    var row: Int
    var column: Int
    var text: String
    
    init(square: Square) {
        switch square.state {
        case .empty: text = ""
        case .filled:
            text = square.player == .player1 ? "❌" : "⭕️"
        }
        
        row = square.position.row
        column = square.position.col
    }
}
