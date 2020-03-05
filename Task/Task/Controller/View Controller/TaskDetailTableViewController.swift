//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Chris Gottfredson on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    //MARK: - Outlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    //MARK: - Properties
    
    var task: Task? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    var dueDateValue: Date?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        dueDateTextField.inputView = dueDatePicker
    }
    
    //MARK: - Actions
    
    @IBAction func saveTaskTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {return}
        let notes = notesTextView.text
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDateValue)
        } else {
            TaskController.shared.add(name: name, notes: notes, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelTaskTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker.date
        dueDateTextField.text = dueDateValue?.stringValue()
    }
    
    @IBAction func userTappedView(_ sender: Any) {
    }
    
    
    //MARK: - Helper Functions
    
    func updateViews() {
        guard let task = task else {return}
        nameTextField.text = task.name
        dueDateTextField.text = task.due?.stringValue()
        notesTextView.text = task.notes
    }
}
