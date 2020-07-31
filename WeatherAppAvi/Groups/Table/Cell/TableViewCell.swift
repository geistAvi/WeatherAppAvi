//
//  TableViewCell.swift
//  WeatherAppAvi
//
//  Created by Alexandr Avizhits on 25.04.2020.
//  Copyright © 2020 AA. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
