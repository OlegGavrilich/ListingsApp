//
//  ProgressTableViewCell.swift
//  ListingsApp
//
//  Created by Oleg Gavrilich on 9/14/20.
//  Copyright © 2020 Oleg Gavrilich. All rights reserved.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!

    func configure(with progressLabel: Int, progressBar: Float) {
        self.progressLabel.text = "\(progressLabel)%"
        self.progressBar.setProgress(progressBar / 100, animated: false)
        self.progressBar.layer.borderWidth = 0.3
    }
    
}
