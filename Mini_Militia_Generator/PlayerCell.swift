//
//  PlayerCell.swift
//  Mini_Militia_Generator
//
//  Created by mihir mehta on 10/04/18.
//  Copyright © 2018 mihir mehta. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var imageViewPlayerPhoto: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var isPresentSwitch: UISwitch!
    weak var player:Player?
    weak var presenceDelegate:PlayerPresenceChangeProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func presenceChanged(_ sender: UISwitch) {
        if let player:Player = self.player {
            player.isPresent = sender.isOn
            self.presenceDelegate?.changePresenceFor(player: player, isPresent: sender.isOn)
        }
    }
}
