//
//  StorageManager.swift
//  CaloriesApp
//
//  Created by Julia Romanenko on 03.09.2022.
//

import Foundation
import CoreData

class StorageManager: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores { descroption, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
                
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save data")
        }
    }
    
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    func editFood(food: Food, newName: String, newCalories: Double, context: NSManagedObjectContext) {
        food.date = Date()
        food.name = newName
        food.calories = newCalories
        
        save(context: context)
    }
    
}
