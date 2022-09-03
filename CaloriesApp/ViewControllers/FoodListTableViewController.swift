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
        tableView.backgroundColor = .orange
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        <#code#>
    }
}

// MARK: - Private functions
extension FoodListTableViewController {
    
}
