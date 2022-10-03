//
//  Game.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/2/22.
//

import Combine
import Foundation

enum Player {
    case player1
    case player2
}

enum GameState {
    case inProgress
    case stalemate
    case gameOver
}

class Game: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var currentPlayer: Player = .player1
    @Published var gameState: GameState = .inProgress
    @Published var grid: [[Square]] = []
    
    // MARK: - Read-Only Properties
    
    private(set) var size: Int
    private(set) var cancellables: Set<AnyCancellable> = []
    private(set) var moves: Int = 0
    
    // MARK: - Internal Properties
    
    var northWest: Square { grid[0][0] }
    var southWest: Square { grid[size - 1][0] }
    var minMovesNeeded: Int { (size * 2) - 1 }
    
    // MARK: - Init
    
    init(size: Int = 4) {
        self.size = size
        buildGrid()
    }
    
    // MARK: - Internal Functions
    
    func newGame() {
        cancellables = []
        gameState = .inProgress
        moves = 0
        grid = []
        buildGrid()
    }
    
    // MARK: - Private Methods
    
    private func switchPlayer() {
        currentPlayer = currentPlayer == .player1 ? .player2 : .player1
    }
    
    private func buildGrid() {
        // Moves from left to right, top to bottom, connecting new Squares to previously set neighbors (to the left, and above)
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
                        square.topLeft = upperLeft
                        upperLeft.bottomRight = square
                    }
                }
                
                if row - 1 >= 0 {
                    let above = grid[row - 1][col]
                    square.top = above
                    above.bottom = square
                    
                    if col < size - 1 {
                        let upperRight = grid[row - 1][col + 1]
                        square.topRight = upperRight
                        upperRight.bottomLeft = square
                    }
                }
            }
        }
    }
    
    // MARK: Win Logic
    
    private func isWinning(square: Square) -> Bool {
        return has2v2WinningGrid(completedBy: square) || hasWinningRow(completedBy: square) || hasWinningColumn(completedBy: square) || hasWinningDiagonal(completedBy: square)
    }
    
    private func has2v2WinningGrid(completedBy square: Square) -> Bool {
        if square.top?.player == square.player {
            if square.left?.player == square.player {
                return square.topLeft?.player == square.player
            } else if square.right?.player == square.player {
                return square.topRight?.player == square.player
            }
        } else if square.bottom?.player == square.player {
            if square.left?.player == square.player {
                return square.bottomLeft?.player == square.player
            } else if square.right?.player == square.player {
                return square.bottomRight?.player == square.player
            }
        }
        
        return false
    }
    
    private func hasWinningColumn(completedBy square: Square) -> Bool {
        return grid.filter({ $0[square.position.col].player == square.player }).count == size
    }
    
    private func hasWinningDiagonal(completedBy square: Square) -> Bool {
        var current: Square?
        if square.position.row == square.position.col { // left diagonal
            current = northWest
            while current != nil {
                if current?.player != square.player {
                    return false
                }
                
                current = current?.bottomRight
            }
            
            return true
        } else if square.position.row == size - square.position.col - 1 { // right diagonal
            current = southWest
            while current != nil {
                if current?.player != square.player {
                    return false
                }
                
                current = current?.topRight
            }
            
            return true
        } else {
            return false
        }
    }
    
    private func hasWinningRow(completedBy square: Square) -> Bool {
        return grid[square.position.row].filter({ $0.player == square.player }).count == size
    }
}

// MARK: - SquareDelegate

extension Game: SquareDelegate {
    func didTapSquare(at position: (row: Int, col: Int)) {
        guard gameState == .inProgress else { return }
        
        // ignore taps on already filled squares
        let square = grid[position.row][position.col]
        guard square.state == .empty else { return }
        
        moves += 1
        square.tap(by: currentPlayer)
        
        // Player doesn't get reset in either of these states. This is a "feature" to allow new games after stalemates
        // to begin with the other player. If there's a winner, the winner gets to go first on the next game.
        if moves >= minMovesNeeded && isWinning(square: square) {
            gameState = .gameOver
            return
        } else if moves == size * size {
            gameState = .stalemate
            return
        }
        
        switchPlayer()
    }
}
