//
//  ListingTableViewCell.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 13.09.2020.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
