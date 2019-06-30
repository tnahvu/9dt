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
    
    // Properties
    static let shared = GameManager()
    private var moves = [Int]()
    private var moveIndexPaths = [IndexPath]()
    private let possibleRows = [0, 1, 2, 3]
    lazy var player: Player = .monkey
    
    private var columns = [
        0: [Player](),
        1: [Player](),
        2: [Player](),
        3: [Player]()
    ]
    
    private var rows = [
        0: [Player](),
        1: [Player](),
        2: [Player](),
        3: [Player]()
    ]
    
    private var diagonalFromBottomLeftIndexPaths = [
        IndexPath(row: 3, section: 0),
        IndexPath(row: 2, section: 1),
        IndexPath(row: 1, section: 2),
        IndexPath(row: 0, section: 3)
    ]
    
    private var diagonalFromBottomLeftPlayers = [Player]()
    
    private var diagonalFromBottomRightIndexPaths = [
        IndexPath(row: 0, section: 0),
        IndexPath(row: 1, section: 1),
        IndexPath(row: 2, section: 2),
        IndexPath(row: 3, section: 3)
    ]
    
    private var diagonalFromBottomRightPlayers = [Player]()

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
                checkForWin(with: acceptableIndexpath, player: player)
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
    
    // Update service with current moves and get new move from service
    private func updateMoves(with currentMoves: [Int]) {

        MovesManager.shared.getMoves(with: currentMoves) { (newMoves, error) in

            if let error = error {
                print(error)
            }
            
            guard
                let verifiedMoves = newMoves,
                let latestMachineMoveColumn = verifiedMoves.last
                else { return }
            
            // Adding latest move for machine/from service
            self.addMove(with: latestMachineMoveColumn)
        }
    }
}

// MARK: Logic

extension GameManager {
    private func checkForWin(with indexPath: IndexPath, player: Player) {
        
        isDiagonalWin(with: indexPath, player: player)
//
//        isColumnWin(with: indexPath, player: player) || isRowWin(with: indexPath, player: player) || isDiagonalWin(with: indexPath, player: player)
    }
    
    private func isColumnWin(with indexPath: IndexPath, player: Player) {
        
        // Check for column win
        columns[indexPath.section]?.append(player)
        
        guard
            let column = columns[indexPath.section],
            column.count == 4,
            column.allSatisfy({ $0 == column.last })
            else { return }
        
        print("WON by column")
    }

    private func isRowWin(with indexPath: IndexPath, player: Player) {
        
        rows[indexPath.row]?.append(player)
        
        guard
            let row = rows[indexPath.row],
            row.count == 4,
            row.allSatisfy({ $0 == row.last })
            else { return }
        
        print("WON by row")
    }

    private func isDiagonalWin(with indexPath: IndexPath, player: Player) {
        
        // Check if move falls into diagonal from bottom left win possibilities
        if diagonalFromBottomLeftIndexPaths.contains(indexPath) {
            diagonalFromBottomLeftPlayers.append(player)
            
            if diagonalFromBottomLeftPlayers.count == 4 &&
                diagonalFromBottomLeftPlayers.allSatisfy({
                    $0 == diagonalFromBottomLeftPlayers.last
                }) {
                print("WON by diagonal bottom left")
            }
        }
        
        // Check if move falls into diagonal from bottom right win possibilities
        if diagonalFromBottomRightIndexPaths.contains(indexPath) {
            diagonalFromBottomRightPlayers.append(player)
            
            if diagonalFromBottomRightPlayers.count == 4 &&
                diagonalFromBottomRightPlayers.allSatisfy({
                    $0 == diagonalFromBottomRightPlayers.last
                }) {
                print("WON by diagonal bottom right")
            }
        }
    }
}

// MARK: Players
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

