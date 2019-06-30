//
//  ViewController.swift
//  9dt
//
//  Created by Tuan Vu on 6/29/19.
//  Copyright © 2019 Tuan Vu. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    // Properties

    lazy private var columnStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private var columnZero = ColumnStackView(with: 0)
    private var columnOne = ColumnStackView(with: 1)
    private var columnTwo = ColumnStackView(with: 2)
    private var columnThree = ColumnStackView(with: 3)
    
    private let startOverButton: UIButton = {
        let button = UIButton()
        button.setTitle("START OVER", for: .normal)
        button.backgroundColor = .barelyThere
        button.roundCorners(with: 12)
        button.addTarget(self, action: #selector(startOver), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // Inits
    
    init(with player: GameManager.Player) {
        super.init(nibName: nil, bundle: nil)
        
        if player == .machine {
           GameManager.shared.startGameWithMachine()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Life cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupSubViews()
        setupConstraints()
        addObservers()
    }
}

// MARK: Setup
extension GridViewController {
    
    private func setup() {
        self.view.backgroundColor = .white
    }
    
    private func setupSubViews() {
        view.addSubview(columnStackView)
        view.addSubview(startOverButton)

        columnStackView.addArrangedSubview(columnZero)
        columnStackView.addArrangedSubview(columnOne)
        columnStackView.addArrangedSubview(columnTwo)
        columnStackView.addArrangedSubview(columnThree)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            startOverButton.widthAnchor.constraint(equalToConstant: Constants.button.primaryButtonWidth),
            startOverButton.heightAnchor.constraint(equalToConstant: 64),
            startOverButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Constants.UI.widePadding),
            startOverButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.UI.standardPadding),
            
            columnStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            columnStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            columnStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            columnStackView.heightAnchor.constraint(equalToConstant: self.view.frame.width)
            ])
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotificationGameOver(with:)), name: .gameEnded, object: nil)
    }
}

//MARK: Actions

extension GridViewController {
    
    @objc private func startOver() {
        NotificationCenter.default.post(name: .clearGame, object: nil)
        GameManager.shared.clearGame()
    }
}

// MARK: Result

extension GridViewController {
    
    @objc private func receivedNotificationGameOver(with notification: Notification) {
        
        guard
            let userInfo = notification.userInfo,
            let result = userInfo[Notification.key.result] as? GameManager.Result
            else { return }


        let alert = UIAlertController(title: result.message, message: "", preferredStyle: .alert)
        
        let playAgainAction = UIAlertAction(title: "OK", style: .default) { action in self.startOver() }

        alert.addAction(playAgainAction)
        
        self.present(alert, animated: true)
    }
}
