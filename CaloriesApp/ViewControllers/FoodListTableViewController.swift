//
//  FoodListTableViewController.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 03.09.2022.
//

import UIKit

final class FoodListTableViewController: UITableViewController {

    private var foodList: [Food] = []
    private let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setupButtonsNavBar()
        
        fetchData()
        tableView.reloadData()
    }
}

// MARK: - Table view data source
extension FoodListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        let food = foodList[indexPath.row]
        
        guard let dateFood = food.date else { return UITableViewCell() }
            
        cell.titleTextLabel.text = food.name
        cell.caloriesLabel.text = "\(Int(food.calories))"
        cell.dateTextLabel.text = calcTimeSinse(date: dateFood)
        
        return cell
    }
}

// MARK: - Table view data source
extension FoodListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        
        let detailsVC = DetailsFoodViewController()
        detailsVC.food = food

        present(detailsVC, animated: true)
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
        tableView.register(CustomCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.separatorColor = CustomColors.darkGreen
    }
    
    private func setupButtonsNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFood))
        addButton.tintColor = CustomColors.darkGreen
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
        
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = CustomColors.darkGreen
    }
    
    private func fetchData() {
        StorageManager.shared.fetchFoods { result in
            switch result {
            case .success(let foods):
                foodList = foods
            case .failure(let error):
                print("Don't fetch data, \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func addNewFood() {
        let detailsVC = DetailsFoodViewController()
        present(detailsVC, animated: true)
    }
}
