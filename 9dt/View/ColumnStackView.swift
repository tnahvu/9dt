//
//  ColumnStackView.swift
//  9dt
//
//  Created by Tuan Vu on 6/29/19.
//  Copyright © 2019 Tuan Vu. All rights reserved.
//

import UIKit

class ColumnStackView: UIView {
    
    // Properties
    private var columnIndex: Int
    
    lazy private var rowZero = TokenView(with: IndexPath(row: 0, section: columnIndex))
    lazy private var rowOne = TokenView(with: IndexPath(row: 1, section: columnIndex))
    lazy private var rowTwo = TokenView(with: IndexPath(row: 2, section: columnIndex))
    lazy private var rowThree = TokenView(with: IndexPath(row: 3, section: columnIndex))
    
    private var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    init(with columnIndex: Int) {
        self.columnIndex = columnIndex

        super.init(frame: .zero)
        setupSubviews()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColumnStackView {
    
    private func setupSubviews() {
        self.addSubview(stackView)
 
        self.stackView.addArrangedSubview(rowZero)
        self.stackView.addArrangedSubview(rowOne)
        self.stackView.addArrangedSubview(rowTwo)
        self.stackView.addArrangedSubview(rowThree)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            ])
    }
}
