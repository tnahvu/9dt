//
//  PlayerManager.swift
//  9dt
//
//  Created by Tuan Vu on 6/29/19.
//  Copyright © 2019 Tuan Vu. All rights reserved.
//

import UIKit

protocol GameManagerDelegate {
    func turnTaken(with player: GameManager.Player, indexPath: IndexPath)
}

class GameManager {
    
    static let shared = GameManager()
    private var moves = [Int]()
    private var moveIndexPaths = [IndexPath]()
    private let possibleRows = [0, 1, 2, 3]

    lazy var player: Player = .monkey

    init(){}
}

// MARK: Actions

extension GameManager {
    
    func addMove(with column: Int) {
        
        // Check if there is available moves left
        // Check if move has been made
        // If both conditions hold true, exit from function
        guard
            moves.count <= 15
            else { return }
        
        // Get all played rows in column
        let playedRowsInColumn = moveIndexPaths.filter { $0.section == column}.compactMap { $0.row }
        
        // Assign lowest available slot (on y axis) in column
        for i in possibleRows.reversed() {
            
            // Find highest unplayed value in column
            if !playedRowsInColumn.contains(i) {
                
                // Assign hightest unplayed value in column
                let acceptableIndexpath = IndexPath(row: i, section: column)
                moveIndexPaths.append(acceptableIndexpath)
                moves.append(column)
                
                // Update UI
                NotificationCenter.default.post(name: .turnTaken, object: nil, userInfo: [
                    Notification.key.indexPathKey: acceptableIndexpath,
                    Notification.key.playerKey: player
                    ])
                
                // Exit from loop once row value has been assigned to column
                break
            }
        }
        
        // Update turn
        switch player {
        case .monkey:
            // Update services with moves from human player
            updateMoves(with: moves)

            player = .machine
        case .machine:
            player = .monkey
        }
    }
    
    private func updateMoves(with currentMoves: [Int]) {

        MovesManager.shared.getMoves(with: currentMoves) { (newMoves, error) in

            if let error = error {
                print(error)
            }
            
            guard
                let verifiedMoves = newMoves,
                let latestMachineMoveColumn = verifiedMoves.last
                else { return }
            
            self.addMove(with: latestMachineMoveColumn)
        }
    }
}

// MARK: Logic

extension GameManager {
    
}

extension GameManager {
    enum Player {
        case monkey
        case machine
        
        var color: UIColor {
            switch self {
            case .monkey:
                return UIColor.red
            case .machine:
                return UIColor.black
            }
        }
    }
}

