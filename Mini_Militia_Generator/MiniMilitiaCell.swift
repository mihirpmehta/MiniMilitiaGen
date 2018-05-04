//
//  MiniMilitiaCell.swift
//  Mini_Militia_Generator
//
//  Created by mihir mehta on 06/12/17.
//  Copyright © 2017 mihir mehta. All rights reserved.
//

import UIKit

class MiniMilitiaCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var mapName: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
