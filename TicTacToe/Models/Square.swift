//
//  Square.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/2/22.
//

import Foundation

protocol SquareDelegate: AnyObject {
    func didTapSquare(at: (row: Int, col: Int))
}

enum SquareState {
    case empty
    case filled
}

/// A Tic Tac Toe Square, intended to be used by a `TTTGame` played by two players.
class Square: NSObject {
    // MARK: - Published Property
    
    @Published var state: SquareState = .empty
    
    // MARK: - Internal Properties
    
    weak var delegate: SquareDelegate!
    var position: (row: Int, col: Int)
    var player: Player?
    
    // MARK: - Init
    
    init(position: (Int, Int), delegate: SquareDelegate) {
        self.position = position
        self.delegate = delegate
    }
    
    // MARK: - Neighbor Squares
    
    var topLeft: Square?
    var top: Square?
    var topRight: Square?
    var right: Square?
    var bottomRight: Square?
    var bottom: Square?
    var bottomLeft: Square?
    var left: Square?
    
    // MARK: - Internal Functions
    
    func tap(by player: Player) {
        guard state == .empty else { return }
        
        self.player = player
        state = .filled
    }
}
