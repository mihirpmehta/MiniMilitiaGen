//
//  TeamViewController.swift
//  Mini_Militia_Generator
//
//  Created by mihir mehta on 07/04/18.
//  Copyright © 2018 mihir mehta. All rights reserved.
//

import UIKit
import AVFoundation

let KillerMachine:Player = Player(name: "Killer Machine", photoName: "karn", originalName: "Karn", style: .Attacking, strength: 10)
let LongPenzer:Player = Player(name: "Long Penzer", photoName: "bandish", originalName: "Bandish", style: .Attacking, strength: 9.5)
let Singham:Player = Player(name: "Singham", photoName: "mihir", originalName: "Mihir", style: .Attacking, strength: 9.5)
let Wolverine:Player = Player(name: "Wolverine", photoName: "niraj", originalName: "Niraj", style: .Attacking, strength: 8.5)
let Bond:Player = Player(name: "Bond", photoName: "ketan", originalName: "Ketan", style: .Attacking, strength: 9)
let Mogambo:Player = Player(name: "Mogambo", photoName: "paresh", originalName: "Paresh", style: .Defencive, strength: 9)
let Rambo:Player = Player(name: "Rambo", photoName: "kundan", originalName: "Kundan", style: [.Attacking,.Defencive], strength: 8)
let Mini:Player = Player(name: "Contract Killer", photoName: "ohm", originalName: "Ohm", style: [.Attacking,.Defencive], strength: 7.5)
let Animal:Player = Player(name: "Hulk", photoName: "tejas", originalName: "Tejas", style:  [.Attacking,.Defencive], strength: 7)
let Chikka:Player = Player(name: "Chikka", photoName: "chirag", originalName: "Chirag", style:  [.Attacking,.Defencive], strength: 7)
let Goldy:Player = Player(name: "Goldy", photoName: "anup", originalName: "Anup", style:  [.Attacking,.Defencive], strength: 7)

protocol PlayerPresenceChangeProtocol:class {
    func changePresenceFor(player:Player,isPresent:Bool)
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

extension Array {
    func chunked(by chunkSize: Int) -> [[Element]] {
        
        if self.count > 0 {
            return stride(from: 0, to: self.count, by: chunkSize).map {
                Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
            }
        } else {
            return [self,self]
        }
    }
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

class TeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,PlayerPresenceChangeProtocol {
    
    
    var marqueePlayers:[Player] = [KillerMachine,LongPenzer,Singham,Mogambo,Bond,Wolverine,Rambo]
    var otherPlayers:[Player] = [Mini,Animal,Chikka,Goldy]
    var allPlayers:[Player] = []
    var allPresentPlayer:[Player] = []
    var presentMarqueePlayers:[Player] = []
    var presentOtherPlayers:[Player] = []
    var teamGenerated:Bool = false
    
    var blueTeam:[Player] = []
    var orangeTeam:[Player] = []
    var extraPlayers:[Player] = []
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var playerTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        allPresentPlayer = marqueePlayers + otherPlayers
        allPlayers = marqueePlayers + otherPlayers
        
        presentMarqueePlayers = marqueePlayers
        presentOtherPlayers = otherPlayers
        
        self.title = "Team Generator"
        
        playerTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    func playSound(for player1:Player) {
        var soundName:String = ""
        if player1.name ==  KillerMachine.name{
            soundName = "wolverine_best"
        }
        else if player1.name ==  Wolverine.name{
            soundName = "wolverine_best"
        }
        else if player1.name ==  Mogambo.name{
            soundName = "message_d_mogambo"
        }
        else if player1.name ==  Bond.name{
            soundName = "my_name_is_bond"
        }
        else if player1.name ==  Rambo.name{
            soundName = "live_for_nothing"
        }
        else if player1.name ==  Mini.name{
            soundName = "wolverine_best"
        }
        else if player1.name ==  LongPenzer.name{
            soundName = "wolverine_best"
        }
        else if player1.name ==  Animal.name{
            soundName = "wolverine_best"
        }
        else if player1.name ==  Goldy.name{
            soundName = "wolverine_best"
        }
        else if player1.name ==  Singham.name{
            soundName = "singham_awesome"
        }
        else if player1.name ==  Chikka.name{
            soundName = "wolverine_best"
        }
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if teamGenerated == false {
            return 1
        } else {
            if extraPlayers.count > 0 {
                return 3
            } else {
                return 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teamGenerated == false {
            return allPlayers.count
        } else {
            if section == 0 {
                return blueTeam.count
            } else if section == 1 {
                return orangeTeam.count
            } else {
                return extraPlayers.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerCell:PlayerCell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        let player:Player
        if teamGenerated == false {
            player = allPlayers[indexPath.row]
        } else {
            if indexPath.section == 0 {
                player = blueTeam[indexPath.row]
            } else if indexPath.section == 1 {
                player = orangeTeam[indexPath.row]
            } else {
                player = extraPlayers[indexPath.row]
            }
        }
        
        playerCell.presenceDelegate = self
        playerCell.player = player
        playerCell.playerName.text = player.name
        playerCell.isPresentSwitch.isOn = player.isPresent
        
        playerCell.imageViewPlayerPhoto.image = UIImage(named: player.photoName)
        
        if teamGenerated {
            playerCell.isPresentSwitch.isHidden = true
            if indexPath.section == 0{
                playerCell.backgroundColor = UIColor.init(red: 135/255, green: 206/255, blue: 250/255, alpha: 0.5)
            }
            else if indexPath.section == 1{
                playerCell.backgroundColor = UIColor.init(red: 255/255 , green: 237/255 ,blue: 204/255, alpha: 1.0)
            }
            else{
                playerCell.backgroundColor = UIColor.clear
                
            }
        }
        else{
            playerCell.isPresentSwitch.isHidden = false
            playerCell.backgroundColor = UIColor.clear
        }
        
        return playerCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if teamGenerated == false {
            return ""
        } else {
            var totalStrength:Double = 0.0
            var bTeamStrength:Double = 0.0
            var oTeamStrength:Double = 0.0
            for player:Player in self.blueTeam {
                totalStrength += player.strength
                bTeamStrength += player.strength
            }
            for player:Player in self.orangeTeam {
                totalStrength += player.strength
                oTeamStrength += player.strength
            }
            if section == 0 {
                return "Blue Team( Winning chance: \(((bTeamStrength/totalStrength)*100).roundToDecimal(2))%)"
            } else if section == 1 {
                return "Orange Team( Winning chance: \(((oTeamStrength/totalStrength)*100).roundToDecimal(2))%)"
            } else {
                return "Both"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if teamGenerated == false {
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if teamGenerated == false {
            return
        }
        
        if let headerView = view as? UITableViewHeaderFooterView  {
            switch(section){
            case 0:
                headerView.backgroundView?.backgroundColor = UIColor.blue
                headerView.textLabel?.textColor = UIColor.white
                break
            case 1:
                headerView.backgroundView?.backgroundColor = UIColor.orange
                headerView.textLabel?.textColor = UIColor.white
                break
            default:
                headerView.backgroundView?.backgroundColor = UIColor.darkGray
                headerView.textLabel?.textColor = UIColor.white
                break
            }
        }
    }
    
    //    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
    ////        if teamGenerated == false{
    ////            return nil
    ////        }
    //
    //        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
    //        if (section == 0) {
    //            headerView.backgroundColor = UIColor.blue
    //        } else if (section == 0) {
    //            headerView.backgroundColor = UIColor.orange
    //        }
    //        else{
    //            headerView.backgroundColor = UIColor.gray
    //        }
    //        return headerView
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player:Player
        if teamGenerated == false {
            player = allPlayers[indexPath.row]
        } else {
            if indexPath.section == 0 {
                player = blueTeam[indexPath.row]
            } else if indexPath.section == 1 {
                player = orangeTeam[indexPath.row]
            } else {
                player = extraPlayers[indexPath.row]
            }
        }
        
        self.playSound(for: player)
    }
    
    func changePresenceFor(player:Player,isPresent: Bool) {
        if isPresent == false {
            //Remove player
            if let index:Int = self.allPresentPlayer.index(where: { (presentPlayer:Player) -> Bool in
                return presentPlayer.name == player.name
            }) {
                self.allPresentPlayer.remove(at: index)
            }
            
            if let index:Int = self.presentMarqueePlayers.index(where: { (presentPlayer:Player) -> Bool in
                return presentPlayer.name == player.name
            }) {
                self.presentMarqueePlayers.remove(at: index)
            }
            
            if let index:Int = self.presentOtherPlayers.index(where: { (presentPlayer:Player) -> Bool in
                return presentPlayer.name == player.name
            }) {
                self.presentOtherPlayers.remove(at: index)
            }
        } else {
            //Add player
            self.allPresentPlayer.append(player)
            if let index:Int = self.marqueePlayers.index(where: { (presentPlayer:Player) -> Bool in
                return presentPlayer.name == player.name
            }) {
                self.presentMarqueePlayers.append(player)
            }
            
            if let index:Int = self.otherPlayers.index(where: { (presentPlayer:Player) -> Bool in
                return presentPlayer.name == player.name
            }) {
                self.presentOtherPlayers.append(player)
            }
        }
        self.playerTableView.reloadData()
    }
    
    @IBAction func generateTeam(_ sender: UIButton) {
        self.teamGenerated = !self.teamGenerated
        if self.teamGenerated {
            // Rendomize array
            var shuffledMerquePlayer:[Player] = []
            var shuffledOtherPlayers:[Player] = []
            
            if self.presentMarqueePlayers.count%2 == 0 && self.presentOtherPlayers.count%2 == 0 {
                // If both are Even
                // Simply split it in 2 after shuffling
                
                shuffledMerquePlayer = self.presentMarqueePlayers.shuffled()
                shuffledOtherPlayers = self.presentOtherPlayers.shuffled()
                
                self.generateTeamFromShuffledArray(shuffledMerquePlayer: shuffledMerquePlayer, shuffledOtherPlayers: shuffledOtherPlayers)
                
                
            } else if self.presentMarqueePlayers.count%2 != 0 && self.presentOtherPlayers.count%2 != 0 {
                // If both are Odd
                // Add Strongest Player of Other player to Marquee player and shuffle it
                //if self.presentOtherPlayers.count > 0 && self.presentMarqueePlayers.count > 0 {
                self.presentMarqueePlayers.append(self.presentOtherPlayers.first!)
                self.presentOtherPlayers.removeFirst()
                shuffledMerquePlayer = self.presentMarqueePlayers.shuffled()
                shuffledOtherPlayers = self.presentOtherPlayers.shuffled()
                
                self.generateTeamFromShuffledArray(shuffledMerquePlayer: shuffledMerquePlayer, shuffledOtherPlayers: shuffledOtherPlayers)
                //                } else {
                //                    // Simply make three team of all player
                //                    shuffledMerquePlayer = self.allPresentPlayer.shuffled()
                //
                //
                //                    var chunk:[[Player]] = shuffledMerquePlayer.chunked(by: shuffledMerquePlayer.count/2)
                //                    self.blueTeam = chunk[0]
                //                    self.orangeTeam = chunk[1]
                //                    self.otherPlayers = chunk[2]
                //                }
            } else if self.presentMarqueePlayers.count%2 == 0 && self.presentOtherPlayers.count%2 != 0 {
                // If marqee is Even and others are odd
                shuffledOtherPlayers = self.presentOtherPlayers.shuffled()
                
                if let player:Player = shuffledOtherPlayers.last {
                    self.extraPlayers = [player]
                    shuffledOtherPlayers.removeLast()
                }
                shuffledMerquePlayer = self.presentMarqueePlayers.shuffled()
                
                
                self.generateTeamFromShuffledArray(shuffledMerquePlayer: shuffledMerquePlayer, shuffledOtherPlayers: shuffledOtherPlayers)
                
            } else if self.presentMarqueePlayers.count%2 != 0 && self.presentOtherPlayers.count%2 == 0 {
                // If marqee is Even and others are odd
                // Add Strongest Player of Other player to Marquee player and shuffle it
                if self.presentOtherPlayers.count > 0 {
                    self.presentMarqueePlayers.append(self.presentOtherPlayers.first!)
                    self.presentOtherPlayers.removeFirst()
                } else {
                    if let player:Player = presentMarqueePlayers.last {
                        self.extraPlayers = [player]
                        presentMarqueePlayers.removeLast()
                    }
                }
                
                shuffledOtherPlayers = self.presentOtherPlayers.shuffled()
                
                if let player:Player = shuffledOtherPlayers.last {
                    self.extraPlayers = [player]
                    shuffledOtherPlayers.removeLast()
                }
                
                shuffledMerquePlayer = self.presentMarqueePlayers.shuffled()
                
                
                self.generateTeamFromShuffledArray(shuffledMerquePlayer: shuffledMerquePlayer, shuffledOtherPlayers: shuffledOtherPlayers)
                
            }
            self.generateButton.setTitle("Reset", for: .normal)
        } else {
            
            presentMarqueePlayers = []
            
            for player:Player in marqueePlayers {
                if player.isPresent == true {
                    presentMarqueePlayers.append(player)
                }
            }
            
            presentOtherPlayers = []
            
            for player:Player in otherPlayers {
                if player.isPresent == true {
                    presentOtherPlayers.append(player)
                }
            }
            
            
            
            
            self.blueTeam = []
            self.orangeTeam = []
            self.extraPlayers = []
            self.generateButton.setTitle("Generate", for: .normal)
        }
        
        self.playerTableView.reloadData()
    }
    
    func generateTeamFromShuffledArray(shuffledMerquePlayer:[Player],shuffledOtherPlayers:[Player]) {
        var chunk:[[Player]] = shuffledMerquePlayer.chunked(by: shuffledMerquePlayer.count/2)
        self.blueTeam = chunk[0]
        self.orangeTeam = chunk[1]
        
        if shuffledOtherPlayers.count > 0{
            let temp:[[Player]] = shuffledOtherPlayers.chunked(by: shuffledOtherPlayers.count/2)
            self.blueTeam.append(contentsOf: temp[0])
            self.orangeTeam.append(contentsOf: temp[1])
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
