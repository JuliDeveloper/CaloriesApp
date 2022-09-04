//
//  DetailsFoodViewController.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 03.09.2022.
//

import UIKit

final class DetailsFoodViewController: UIViewController {

    var food: Food?
    var delegate: FoodViewControllerDelegate?
    
    let foodNameTextField: UITextField = {
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
    
    lazy var caloriesSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1000
        slider.value = 100
        slider.tintColor = CustomColors.darkGreen
        slider.thumbTintColor = CustomColors.middleGreen
        slider.addTarget(self, action: #selector(changeValue), for: .allTouchEvents)
        return slider
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add food"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = CustomColors.darkGreen
        label.textAlignment = .center
        return label
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
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
        
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        setupVerticalStackView()
    }
    
}

// MARK: - Private functions
extension DetailsFoodViewController {
    private func configView() {
        view.backgroundColor = CustomColors.backgroundColor
        caloriesLabel.text = "Calories: \(Int(caloriesSlider.value))"
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = CustomColors.darkGreen
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
            stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func saveFood() {
        if food == nil {
            StorageManager.shared.addFood(name: foodNameTextField.text ?? "",
                                          calories: Double(caloriesSlider.value))
        } else {
            StorageManager.shared.editFood(food: food ?? Food(),
                                           newName: foodNameTextField.text ?? "",
                                           newCalories: Double(caloriesSlider.value))
        }
        delegate?.reloadData()
        dismiss(animated: true)
    }
    
    @objc private func changeValue() {
        let step: Float = 10
        let currentValue = round(caloriesSlider.value / step) * step
        caloriesLabel.text = "Calories: \(Int(currentValue))"
        print(currentValue)
    }
}
