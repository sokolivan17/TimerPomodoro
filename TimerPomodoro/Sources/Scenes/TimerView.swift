//
//  TimerView.swift
//  TimerPomodoro
//
//  Created by Ваня Сокол on 18.05.2022.
//

import UIKit

class TimerView: UIViewController {

    private var timer = Timer()
    private var durationTimer = Metric.workTimeValue {
        didSet {
            labelTimer.text = durationTimer < Metric.workTimeValue ? "00:0\(durationTimer)" : "00:\(durationTimer)"
        }

    }
    private var isStarted = false {
        didSet {
            button.isSelected = isStarted
        }
    }
    private var isWorkTime = true {
        didSet {
            durationTimer = isWorkTime ? Metric.workTimeValue : Metric.relaxTimeValue
            labelTimer.textColor = isWorkTime ? Color.workState : Color.relaxState
            setButtonColor()
        }
    }

    private lazy var labelTimer: UILabel = {
        var labelTimer = UILabel()
        labelTimer.text = String(format: "%02i:%02i", Metric.minutes, Metric.seconds)
        labelTimer.textColor = isWorkTime ? Color.workState : Color.relaxState
        labelTimer.font = .systemFont(ofSize: Metric.labelSize)
        labelTimer.sizeToFit()
        return labelTimer
    }()

    private lazy var button: UIButton = {
        let currentColor = isWorkTime ? Color.workState : Color.relaxState
        var button = UIButton(type: .system)
        let configurationImage = UIImage.SymbolConfiguration(pointSize: Metric.buttonSize)
        button.tintColor = .clear
        button.setPreferredSymbolConfiguration(configurationImage, forImageIn: .normal)
        button.setImage(Icons.play?.withTintColor(currentColor, renderingMode: .alwaysOriginal), for: .normal)
        button.setImage(Icons.pause?.withTintColor(currentColor, renderingMode: .alwaysOriginal), for: .selected)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

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

    private func setButtonColor() {
        let currentColor = isWorkTime ? Color.workState : Color.relaxState
        let playIcon = Icons.play?.withTintColor(currentColor, renderingMode: .alwaysOriginal)
        let pauseIcon = Icons.pause?.withTintColor(currentColor, renderingMode: .alwaysOriginal)
        button.setImage(playIcon, for: .normal)
        button.setImage(pauseIcon, for: .selected)
    }

    // MARK: - Actions

    @objc private func timerAction() {
        guard durationTimer > 0  else {
            isStarted = !isStarted
            isWorkTime = !isWorkTime
            timer.invalidate()
            return
        }

        durationTimer -= 1
    }

    @objc private func buttonAction() {
        isStarted = !isStarted

        if isStarted {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
        }
    }


}

extension TimerView {
    enum Icons {
        static let pause = UIImage(systemName: "pause")
        static let play = UIImage(systemName: "play")
    }

    enum Metric {
        static let labelSize: CGFloat = 100
        static let buttonSize: CGFloat = 80
        static let workTimeValue = 10
        static let relaxTimeValue = 5
        static let minutes = workTimeValue / 60 % 60
        static let seconds = workTimeValue % 60
    }

    enum Color {
        static let workState = UIColor.black
        static let relaxState = UIColor.white
    }
}
