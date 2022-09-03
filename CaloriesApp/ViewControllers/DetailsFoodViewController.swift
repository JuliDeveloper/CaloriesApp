//
//  DetailsFoodViewController.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 03.09.2022.
//

import UIKit

final class DetailsFoodViewController: UIViewController {
    
    private let foodNameTextField: UITextField = {
        let tf = UITextField()
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 31))
        tf.leftView = spacer
        tf.leftViewMode = .always
        tf.placeholder = "Food name"
        tf.layer.borderWidth = 2
        tf.layer.borderColor = CustomColors.darkGreen.cgColor
        tf.layer.cornerRadius = Constants.radius
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories: "
        return label
    }()
    
    private let caloriesSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1000
        slider.value = 100
        slider.tintColor = CustomColors.darkGreen
        slider.thumbTintColor = CustomColors.middleGreen
        return slider
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = CustomColors.darkGreen
        button.layer.cornerRadius = Constants.radius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(saveFood), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        setupVerticalStackView()
    }
    
}

// MARK: - Private functions
extension DetailsFoodViewController {
    private func configView() {
        view.backgroundColor = CustomColors.backgroundColor
    }
    
    private func setupCaloriesStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [caloriesLabel, caloriesSlider])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }
    
    private func setupVerticalStackView() {
        let caloriesStack = setupCaloriesStackView()
        
        let stack = UIStackView(arrangedSubviews: [foodNameTextField,
                                                   caloriesStack,
                                                   saveButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        
        view.addSubview(stack)
        
        setupConstraints(for: stack)
    }
    
    private func setupConstraints(for stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func saveFood() {
        
    }
}
