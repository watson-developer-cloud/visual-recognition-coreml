//
//  ResultsTableViewCell.swift
//  Core ML Vision Discovery
//
//  Created by Iain McCown on 12/4/17.
//  Copyright © 2017 Iain McCown. All rights reserved.
//

import UIKit

class ResultTableClassificationViewCell: UITableViewCell {
    
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var damageLabel: UILabel!
    
}

class ResultTableDiscoveryViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var classificationLabel: UILabel!
    
}

