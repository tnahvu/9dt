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
    
    private var moves = [IndexPath]()
    private let acceptableRows = [0, 1, 2, 3]

    lazy var player: Player = .blue

    init(){}
}

// MARK: Actions

extension GameManager {
    
    func addMove(with indexPath: IndexPath) {

        // Check if there is available moves left
        // Check if move has been made
        // If both conditions hold true, exit from function
        guard
            moves.count <= 15,
            !moves.contains(indexPath)
            else { return }

        // Get all played rows in column
        let columnTurns = moves.filter { $0.section == indexPath.section}.compactMap { $0.row }

        // Assign lowest available slot (on y axis) in column
        for i in acceptableRows.reversed() {
            if !columnTurns.contains(i) {
                let acceptableIndexpath = IndexPath(row: i, section: indexPath.section)
                moves.append(acceptableIndexpath)

                // Update UI 
                NotificationCenter.default.post(name: .turnTaken, object: nil, userInfo: [
                    Notification.key.indexPathKey: acceptableIndexpath,
                    Notification.key.playerKey: player
                    ])

                break
            }
        }

        // Update turn
        switch player {
        case .blue:
            player = .red
        case .red:
            player = .blue
        }
    }
}

extension GameManager {
    enum Player {
        case blue
        case red
        
        var color: UIColor {
            switch self {
            case .blue:
                return UIColor.blue
            case .red:
                return UIColor.red
            }
        }
    }
}

