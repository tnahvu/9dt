//
//  StartViewController.swift
//  9dt
//
//  Created by Tuan Vu on 6/30/19.
//  Copyright © 2019 Tuan Vu. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // Properties
    
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "You feeling lucky, monkey?"
        label.font = UIFont.systemFont(ofSize: 64, weight: .bold)
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let noButton: UIButton = {
       let button = UIButton()
        button.setTitle("Heooo nawww", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .thin)
        button.addTarget(self, action: #selector(noButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black

        return button
    }()
    
    private let yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Shaw do.  Let me go first!", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.addTarget(self, action: #selector(yesButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        
        return button
    }()
    
    // Life cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
    }
}

// MARK: Setup

extension StartViewController {
    
    private func setup(){
        
    }
    
    private func setupSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(noButton)
        self.view.addSubview(yesButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.UI.widePadding),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.UI.widePadding),

            yesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            yesButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            yesButton.bottomAnchor.constraint(equalTo: self.noButton.topAnchor, constant: -Constants.UI.hairline),
            yesButton.heightAnchor.constraint(equalToConstant: Constants.button.primaryButtonWidth),
            
            noButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            noButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            noButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            noButton.heightAnchor.constraint(equalToConstant: Constants.button.primaryButtonWidth)
            ])
    }
}

// MARK: Actions

extension StartViewController {
    
    @objc private func noButtonPressed() {
        let viewController = GridViewController(with: .machine)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func yesButtonPressed() {
        let viewController = GridViewController(with: .monkey)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
