//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Chris Gottfredson on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var delegate: ButtonTableViewCellDelegate?
    
    //MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    func updateButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension ButtonTableViewCell {
    func update(task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}
