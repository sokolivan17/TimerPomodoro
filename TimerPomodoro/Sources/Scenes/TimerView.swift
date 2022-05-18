//
//  TimerView.swift
//  TimerPomodoro
//
//  Created by Ваня Сокол on 18.05.2022.
//

import UIKit

class TimerView: UIViewController {

    private lazy var labelTimer: UILabel = {
        var labelTimer = UILabel()
        labelTimer.text = "25:00"
        labelTimer.textColor = .black
        labelTimer.font = .systemFont(ofSize: 80)
        labelTimer.sizeToFit()
        return labelTimer
    }()

    private lazy var button: UIButton = {
        var button = UIButton(type: .system)
        let configurationImage = UIImage.SymbolConfiguration(pointSize: 60)
        let imageButton = UIImage(systemName: "play", withConfiguration: configurationImage)
        button.setImage(imageButton, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2

        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        view.addSubview(labelTimer)
        view.addSubview(button)

    }

    private func setupLayout() {
        labelTimer.translatesAutoresizingMaskIntoConstraints = false
        labelTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true

        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true

    }




}

