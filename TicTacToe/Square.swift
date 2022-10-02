//
//  Square.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/2/22.
//

import Foundation

protocol SquareDelegate: AnyObject {
    func didTapSquare(_ square: Square, at: (row: Int, col: Int))
}

enum SquareState {
    case empty
    case player1
    case player2
}

/// A Tic Tac Toe Square, intended to be used by a `TTTGame` played by two players.
class Square {
    weak var delegate: SquareDelegate!
    var position: (row: Int, col: Int)
    var state: SquareState = .empty
    
    init(position: (Int, Int), delegate: SquareDelegate) {
        self.position = position
        self.delegate = delegate
    }
    
    var left: Square?
    var upperLeft: Square?
    var above: Square?
    var upperRight: Square?
    var right: Square?
    var bottomRight: Square?
    var below: Square?
    var bottomLeft: Square?
    
    /// Whether this Square exists on the inside of the Game perimeter.
    ///
    /// `isInnerSquare` is true when the Square is not on the outer edge of the Game grid. There's probably an argument to be had whether this should exist on
    /// `Game` instead.
    var isInnerSquare: Bool {
        left != nil && upperLeft != nil && above != nil && upperRight != nil && right != nil && bottomRight != nil && below != nil && bottomLeft != nil
    }
}