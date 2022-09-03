//
//  StorageManager.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 03.09.2022.
//

import UIKit
import CoreData

class StorageManager: ObservableObject {
    
    static let shared = StorageManager()
    lazy var context = StorageManager.shared.persistentContainer.viewContext
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Food saved!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addFood(name: String, calories: Double) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        saveContext()
    }
    
    func editFood(food: Food, newName: String, newCalories: Double) {
        food.date = Date()
        food.name = newName
        food.calories = newCalories
        
        saveContext()
    }
    
    func deleteFood(food: Food) {
        context.delete(food)
        saveContext()
    }
    
    private init() {}
}

extension StorageManager {
    func fetchFoods(_ completion: (Result<[Food], Error>) -> (Void)) {
        let fetchRequest = Food.fetchRequest()
        
        do {
            let foods = try context.fetch(fetchRequest)
            completion(.success(foods))
        } catch let error {
            completion(.failure(error))
        }
    }
}
