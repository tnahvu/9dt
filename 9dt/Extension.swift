//
//  Extension.swift
//  9dt
//
//  Created by Tuan Vu on 6/30/19.
//  Copyright © 2019 Tuan Vu. All rights reserved.
//

import UIKit

extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = self.bounds.width/2
        self.clipsToBounds = true
    }
    
    func roundCorners(with radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

extension UIColor {
    class var barelyThere: UIColor {
        return UIColor(white: 25.0 / 255.0, alpha: 0.2)
    }
}

extension Notification.Name {
    static let turnTaken = Notification.Name("turnTaken")
    static let clearGame = Notification.Name("clearGame")
    static let gameEnded = Notification.Name("gameEnded")
}

extension Notification {
    enum key {
        static let indexPathKey = "indexPathKey"
        static let playerKey = "player"
        static let result = "gameResult"
    }
}
