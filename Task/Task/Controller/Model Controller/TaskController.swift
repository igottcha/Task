//
//  TaskController.swift
//  Task
//
//  Created by Chris Gottfredson on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    //MARK: - Singleton
    
    static let shared = TaskController()
    
    //MARK: - Properties
    
    var tasks: [Task] = []
    
    init() {
        tasks = fetchTasks()
    }
    
    let mockTasks: [Task] = {
        let task1 = Task(name: "Buy Groceries", notes: "Milk, Eggs, Bread", due: Date())
        let task2 = Task(name: "Meet Johnny for Lunch", notes: "", due: Date())
        let task3 = Task(name: "Dominate at League", notes: "", due: Date(), isComplete: true)
        return [task1, task2, task3]
    }()
    
    func fetchTasks() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func add(name: String, notes: String?, due: Date?) {
        Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error saving the data!!!\n \(#function)\n \(error.localizedDescription)")
        }
    }
}
