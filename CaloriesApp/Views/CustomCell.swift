//
//  CustomCell.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 04.09.2022.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let caloriesTextLabel: UILabel = {
        let label = UILabel()
        label.text = "calories"
        label.textAlignment = .left
        label.textColor = CustomColors.darkGreen
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let dateTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .gray
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = CustomColors.backgroundColor
        selectionStyle = .none
        
        configGeneralStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configSubtitleStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [caloriesLabel,
                                                   caloriesTextLabel])
        
        stack.axis = .horizontal
        stack.spacing = 5
        
        return stack
    }
    
    private func configTitliesStack() -> UIStackView {
        let subtitleStack = configSubtitleStack()
        
        let stack = UIStackView(arrangedSubviews: [titleTextLabel,
                                                   subtitleStack])
        
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
    }
    
    private func configGeneralStack() {
        
        let titleStack = configTitliesStack()
        
        let stack = UIStackView(arrangedSubviews: [titleStack,
                                                   dateTextLabel])
        
        stack.axis = .horizontal
        stack.spacing = 20
        
        addSubview(stack)
        configConstraints(for: stack)
    }
    
    
    private func configConstraints(for stack: UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
