//
//  DetailsTableViewCell.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 9/13/20.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var secondaryTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with mainTitle: String, secondaryTitle: String) {
        self.mainTitle.text = mainTitle
        self.secondaryTitle.text = secondaryTitle
    }
}
