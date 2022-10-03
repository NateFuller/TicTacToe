//
//  SquareView.swift
//  TicTacToe
//
//  Created by Nathan Fuller on 10/3/22.
//

import SwiftUI

struct SquareView: View {
    var viewModel: SquareViewModel
    var tapHandler: ((row: Int, col: Int)) -> Void
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .border(Color("border"), width: 0.5)
                Text(viewModel.text)
                    .font(.largeTitle)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(idealWidth: 100, maxWidth: 100)
        .onTapGesture {
            tapHandler((row: viewModel.row, col: viewModel.column))
        }
    }
}
