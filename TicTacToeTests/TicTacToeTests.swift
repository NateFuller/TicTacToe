//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Nathan Fuller on 10/2/22.
//

import XCTest
@testable import TicTacToe

final class TicTacToeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTicTacToeGame_size() throws {
        let size = Int.random(in: 4...10)
        let game = Game(size: size)
        
        var squareCount = 0
        
        for row in game.grid {
            for _ in row {
                squareCount += 1
            }
        }
        
        XCTAssertEqual(squareCount, size * size)
    }
    
    func testGame_innerSquareReferences() throws {
        let game = Game()
        
        let innerSquare = game.grid[1][1]
        XCTAssertIdentical(innerSquare.upperLeft, game.grid[0][0])
        XCTAssertIdentical(game.grid[0][0].bottomRight, innerSquare)
        
        XCTAssertIdentical(innerSquare.above, game.grid[0][1])
        XCTAssertIdentical(game.grid[0][1].below, innerSquare)
        
        XCTAssertIdentical(innerSquare.upperRight, game.grid[0][2])
        XCTAssertIdentical(game.grid[0][2].bottomLeft, innerSquare)
        
        XCTAssertIdentical(innerSquare.left, game.grid[1][0])
        XCTAssertIdentical(game.grid[1][0].right, innerSquare)
        
        XCTAssertIdentical(innerSquare.right, game.grid[1][2])
        XCTAssertIdentical(game.grid[1][2].left, innerSquare)
        
        XCTAssertIdentical(innerSquare.bottomLeft, game.grid[2][0])
        XCTAssertIdentical(game.grid[2][0].upperRight, innerSquare)
        
        XCTAssertIdentical(innerSquare.below, game.grid[2][1])
        XCTAssertIdentical(game.grid[2][1].above, innerSquare)
        
        XCTAssertIdentical(innerSquare.bottomRight, game.grid[2][2])
        XCTAssertIdentical(game.grid[2][2].upperLeft, innerSquare)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
