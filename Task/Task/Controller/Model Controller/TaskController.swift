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
    
    var tasks: [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    //MARK: - CRUD Functions
    
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
    
   private func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error saving the data!!!\n \(#function)\n \(error.localizedDescription)")
        }
    }
}
