//
//  DetailsFoodViewController.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 03.09.2022.
//

import UIKit

class DetailsFoodViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
}

// MARK: - Private functions
extension DetailsFoodViewController {
    private func configView() {
        view.backgroundColor = CustomColors.backgroundColor
    }
}
