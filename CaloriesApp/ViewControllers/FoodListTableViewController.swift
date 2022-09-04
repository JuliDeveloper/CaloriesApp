//
//  FoodListTableViewController.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 03.09.2022.
//

import UIKit

protocol FoodViewControllerDelegate {
    func reloadData()
}

final class FoodListTableViewController: UITableViewController {

    var foodList: [Food] = []
    
    private let cellIdentifier = "cell"
    private let headerIdentifier = "header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        setupButtonsNavBar()
        
        fetchData()
    }
}

// MARK: - Table view data source
extension FoodListTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as? CustomHeader else { return UITableViewHeaderFooterView() }
        view.titleLabel.text = "\(Int(totalCaloriesToday())) Kcal (Today)"
        tableView.reloadSections([0,0], with: .automatic)
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomCell else { return UITableViewCell() }
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
        detailsVC.foodNameTextField.text = food.name
        detailsVC.caloriesSlider.value = Float(food.calories)
        detailsVC.titleLabel.text = "Edit food"
        detailsVC.delegate = self

        present(detailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        if editingStyle == .delete {
            foodList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteFood(food: food)
        }
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
        tableView.register(CustomCell.self,
                           forCellReuseIdentifier: cellIdentifier)
        tableView.register(CustomHeader.self,
               forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
        tableView.separatorColor = CustomColors.darkGreen
    }
    
    private func setupButtonsNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFood))
        addButton.tintColor = CustomColors.darkGreen
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
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
    
    private func totalCaloriesToday() -> Double {
        var caloriesToday: Double = 0
        
        for food in foodList {
            if Calendar.current.isDateInToday(food.date ?? Date()) {
                caloriesToday += food.calories
            }
        }
        
        return caloriesToday
    }
    
    @objc private func addNewFood() {
        let detailsVC = DetailsFoodViewController()
        detailsVC.titleLabel.text = "Add food"
        detailsVC.delegate = self
        present(detailsVC, animated: true)
    }
}

extension FoodListTableViewController: FoodViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}
