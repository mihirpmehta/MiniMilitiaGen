//
//  Player.swift
//  Mini_Militia_Generator
//
//  Created by mihir mehta on 07/04/18.
//  Copyright © 2018 mihir mehta. All rights reserved.
//



import Foundation

struct PlayingStyle: OptionSet,Codable {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    public static let Attacking  = PlayingStyle(rawValue: 1 << 0)
    public static let Defencive = PlayingStyle(rawValue: 1 << 1)
    
}



class Player:Codable {
    let name:String
    let photoName:String
    let originalName:String
    let style:PlayingStyle
    let strength:Double
    var isPresent:Bool = true
    
    init(name:String, photoName:String, originalName:String,style:PlayingStyle,strength:Double) {
        self.name = name
        self.photoName = photoName
        self.originalName = originalName
        self.style = style
        self.strength = strength
    }
    
}
