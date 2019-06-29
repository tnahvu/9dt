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

        columnStackView.addArrangedSubview(columnZero)
        columnStackView.addArrangedSubview(columnOne)
        columnStackView.addArrangedSubview(columnTwo)
        columnStackView.addArrangedSubview(columnThree)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            columnStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            columnStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            columnStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            columnStackView.heightAnchor.constraint(equalToConstant: self.view.frame.width)
            ])
    }
    
}

