//
//  TokenView.swift
//  9dt
//
//  Created by Tuan Vu on 6/26/19.
//  Copyright © 2019 Tuan Vu. All rights reserved.
//

import UIKit

class TokenView: UIView {
    
    // Properties
    
    private var circleView: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        return view
    }()
    
    private var indexPath: IndexPath

    init(with indexPath: IndexPath) {
        self.indexPath = indexPath

        super.init(frame: .zero)
        setup()
        setupSubviews()
        setupConstraints()
        addNotificationObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Make circular using rounded corner radius only after sizes have been given
        circleView.makeCircular()
    }
}

// MARK: Setup

extension TokenView {

    private func setup() {
        self.backgroundColor = .barelyThere
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func setupSubviews(){
        self.addSubview(circleView)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            circleView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
            ])
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotificationForTurn(with:)), name: .turnTaken, object: nil)
    }
}

// MARK: Actions

extension TokenView {
    
    @objc func buttonTapped() {
        GameManager.shared.addMove(with: indexPath)
    }
    
    func configure(with turn: GameManager.Player) {
        self.circleView.backgroundColor = turn.color
    }
    
    @objc private func receivedNotificationForTurn(with notification: Notification) {
        
        guard
            let userInfo = notification.userInfo,
            let indexPath = userInfo[Notification.key.indexPathKey] as? IndexPath,
            let player = userInfo[Notification.key.playerKey] as? GameManager.Player,
            self.indexPath == indexPath
        else { return }

        configure(with: player)
    }
}

extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = self.bounds.width/2
        self.clipsToBounds = true
    }
    
//    func cutOutTransparentOverlay() {
//        let path = UIBezierPath()
//        let sizes = CGSize(width: self.bounds.width * 0.8, height: self.bounds.height * 0.8)
//        let circlePath = UIBezierPath(ovalIn: CGRect(origin: self.frame.origin, size: sizes))
//        path.append(circlePath)
//
//        let maskLayer = CAShapeLayer() //create the mask layer
//        maskLayer.path = path.cgPath // Give the mask layer the path you just draw
//        maskLayer.fillRule = .evenOdd // Cut out the intersection part
//        self.layer.mask = maskLayer
//    }
}

extension UIColor {
    class var barelyThere: UIColor {
        return UIColor(white: 25.0 / 255.0, alpha: 0.2)
    }
}

extension Notification.Name {
    static let turnTaken = Notification.Name("turnTaken")
}

extension Notification {
    enum key {
        static let indexPathKey = "indexPathKey"
        static let playerKey = "player"
    }
}
