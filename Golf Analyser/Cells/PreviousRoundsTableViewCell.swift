//
//  PreviousRoundsTableViewCell.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 11/16/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit

class PreviousRoundsTableViewCell: UITableViewCell {

    @IBOutlet weak var parLbl: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
