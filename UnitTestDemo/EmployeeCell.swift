//
//  EmployeeCell.swift
//  UnitTestDemo
//
//  Created by Atul Kumar Tiwari-iOS on 12/08/19.
//  Copyright © 2019 Tokopedia. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var salaryLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    internal func populate(with employee: Employee) {
        idLabel.text = "Name: \(employee.id)"
        salaryLabel.text = "salary: \(employee.employee_salary)"
        nameLabel.text = "Name: \(employee.employee_name)"
        imageLabel.text = "Image: \(employee.profile_image)"
        
    }
    
}
