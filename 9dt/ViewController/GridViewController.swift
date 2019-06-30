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

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupSubViews()
        setupConstraints()
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
}

//MARK: Actions

extension GridViewController {
    
    @objc private func startOver() {
        NotificationCenter.default.post(name: .clearGame, object: nil)
        GameManager.shared.clearGame()
    }
}
