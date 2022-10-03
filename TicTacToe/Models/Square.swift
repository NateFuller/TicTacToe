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
    weak var delegate: SquareDelegate!
    var position: (row: Int, col: Int)
    var player: Player?
    
    @Published var state: SquareState = .empty
    
    init(position: (Int, Int), delegate: SquareDelegate) {
        self.position = position
        self.delegate = delegate
    }
    
    var topLeft: Square?
    var top: Square?
    var topRight: Square?
    var right: Square?
    var bottomRight: Square?
    var bottom: Square?
    var bottomLeft: Square?
    var left: Square?
    
    /// Whether this Square exists on the inside of the Game perimeter.
    ///
    /// `isInnerSquare` is true when the Square is not on the outer edge of the Game grid. There's probably an argument to be had whether this should exist on
    /// `Game` instead.
    var isInnerSquare: Bool {
        left != nil && topLeft != nil && top != nil && topRight != nil && right != nil && bottomRight != nil && bottom != nil && bottomLeft != nil
    }
    
    func tap(by player: Player) {
        guard state == .empty else { return }
        
        self.player = player
        state = .filled
    }
}
