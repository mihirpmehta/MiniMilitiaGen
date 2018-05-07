//
//  Map.swift
//  Mini_Militia_Generator
//
//  Created by mihir mehta on 06/12/17.
//  Copyright © 2017 mihir mehta. All rights reserved.
//

import Foundation

//let OUTPOST:Map = Map("OUTPOST", index: 1)
//let HIGHTOWER:Map = Map("HIGH TOWER", index: 2)
//let SUBDIVISION:Map = Map("SUBDIVISION", index: 3)
//let BOTTLENECK:Map = Map("BOTTLE NECK", index: 4)
//let NOESCAPE:Map = Map("NO ESCAPE", index: 5)
//let SOLONG:Map = Map("SO LONG", index: 6)
//let LUNARCY:Map = Map("LUNARCY", index: 7)
//let ICEBOX:Map = Map("ICEBOX", index: 8,isInSnow:true)
//let SNOWBLIND:Map = Map("SNOW BLIND", index: 9,isInSnow:true)
//let PYRAMID:Map = Map("PYRAMID", index: 10)
//let CATACOMBS:Map = Map("CATACOMBS", index: 11)
//let OVERSEER:Map = Map("OVERSEER", index: 12)
//let SUSPENSION:Map = Map("SUSPENSION", index: 13)
//let CLIFHANGER:Map = Map("CLIFHANGER", index: 14)
//let CROSSFIRE:Map = Map("CROSSFIRE", index: 15)
//let UNDERMINE:Map = Map("UNDERMINE", index: 16)

class Map:Codable {
    let name:String
    let index:Int
    let isInSnow:Bool
    init(_ name:String, index:Int,isInSnow:Bool = false) {
        self.name = name
        self.index = index
        self.isInSnow = isInSnow
    }
    static func getMapFromIndex(_ index:Int) -> Map? {
        
        switch index {
        case 1:
            return OUTPOST
        case 2:
            return HIGHTOWER
        case 3:
            return SUBDIVISION
        case 4:
           return BOTTLENECK
        case 5:
            return NOESCAPE
        case 6:
            return SOLONG
        case 7:
            return LUNARCY
        case 8:
            return ICEBOX
        case 9:
            return SNOWBLIND
        case 10:
            return PYRAMID
        case 11:
            return CATACOMBS
        case 12:
            return OVERSEER
        case 13:
            return SUSPENSION
        case 14:
            return CLIFHANGER
        case 15:
            return CROSSFIRE
        case 16:
            return UNDERMINE
        default:
            return nil
        }
    }
}
