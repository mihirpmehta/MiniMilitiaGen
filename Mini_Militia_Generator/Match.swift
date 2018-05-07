//
//  Match.swift
//  Mini_Militia_Generator
//
//  Created by mihir mehta on 06/05/18.
//  Copyright © 2018 mihir mehta. All rights reserved.
//

import Foundation

class Match: Codable {
    let map:Map
    let blueTeam:[Player]
    let orangeTeam:[Player]
    let extraPlayer:[Player]
    
    init(map:Map, blueTeam:[Player], orangeTeam:[Player],extraPlayer:[Player]) {
        self.map = map
        self.blueTeam = blueTeam
        self.orangeTeam = orangeTeam
        self.extraPlayer = extraPlayer
    }
}
