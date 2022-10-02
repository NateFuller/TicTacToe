//
//  Game.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/2/22.
//

import Foundation

enum Player {
    case x
    case o
}

enum GameState {
    case xMove
    case oMove
    case winner(player: Player)
}

class Game {
    var size: Int
    var grid: [[Square]] = []
    var gameState: GameState = .xMove
    
    var northWest: Square { grid[0][0] }
    var northEast: Square { grid[0][size - 1] }
    var southWest: Square { grid[size - 1][0] }
    var southEast: Square { grid[size - 1][size - 1] }
    
    init(size: Int = 4) {
        self.size = size
        buildGrid()
    }
    
    private func buildGrid() {
        // Moves from left to right, top to bottom, assuming that all squares to the left and above the current position are already populated.
        for row in 0 ..< size {
            for col in 0 ..< size {
                let square = Square(position: (row: row, col: col), delegate: self)
                
                if grid.count == row {
                    grid.append([])
                }
                
                grid[row].append(square)
                
                if col - 1 >= 0 {
                    let left = grid[row][col - 1]
                    square.left = left
                    left.right = square
                    
                    if row - 1 >= 0 {
                        let upperLeft = grid[row - 1][col - 1]
                        square.upperLeft = upperLeft
                        upperLeft.bottomRight = square
                    }
                }
                
                if row - 1 >= 0 {
                    let above = grid[row - 1][col]
                    square.above = above
                    above.below = square
                    
                    if col < size - 1 {
                        let upperRight = grid[row - 1][col + 1]
                        square.upperRight = upperRight
                        upperRight.bottomLeft = square
                    }
                }
            }
        }
    }
}

extension Game: SquareDelegate {
    func didTapSquare(_ square: Square, at: (row: Int, col: Int)) {
        
    }
}
