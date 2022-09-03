//
//  FoodListTableViewController.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 03.09.2022.
//

import UIKit

private let reuseIdentifier = "cell"

final class FoodListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setupButtonsNavBar()
    }
}

// MARK: - Table view data source
extension FoodListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        

        return cell
    }
}

// MARK: - Table view data source
extension FoodListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Private functions
extension FoodListTableViewController {
    private func configTableView() {
        title = "CaloriesApp"
        navigationController?.navigationBar.barTintColor = CustomColors.lightGreen
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: CustomColors.darkGreen
        ]
        
        view.backgroundColor = CustomColors.backgroundColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.separatorColor = CustomColors.darkGreen
    }
    
    private func setupButtonsNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFood))
        addButton.tintColor = CustomColors.darkGreen
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
        
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = CustomColors.darkGreen
    }
    
    @objc private func addNewFood() {
        let detailsVC = DetailsFoodViewController()
        present(detailsVC, animated: true)
    }
}
