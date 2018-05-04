//
//  ViewController.swift
//  Mini_Militia_Generator
//
//  Created by mihir mehta on 06/12/17.
//  Copyright © 2017 mihir mehta. All rights reserved.
//

import UIKit

let OUTPOST:Map = Map("OUTPOST", index: 1)
let HIGHTOWER:Map = Map("HIGH TOWER", index: 2)
let SUBDIVISION:Map = Map("SUBDIVISION", index: 3)
let BOTTLENECK:Map = Map("BOTTLE NECK", index: 4)
let NOESCAPE:Map = Map("NO ESCAPE", index: 5)
let SOLONG:Map = Map("SO LONG", index: 6)
let LUNARCY:Map = Map("LUNARCY", index: 7)
let ICEBOX:Map = Map("ICEBOX", index: 8,isInSnow:true)
let SNOWBLIND:Map = Map("SNOW BLIND", index: 9,isInSnow:true)
let PYRAMID:Map = Map("PYRAMID", index: 10)
let CATACOMBS:Map = Map("CATACOMBS", index: 11)
let OVERSEER:Map = Map("OVERSEER", index: 12)
let SUSPENSION:Map = Map("SUSPENSION", index: 13)
let CLIFHANGER:Map = Map("CLIFHANGER", index: 14)
let CROSSFIRE:Map = Map("CROSSFIRE", index: 15)
let UNDERMINE:Map = Map("UNDERMINE", index: 16)

let ALL_MAPS:[Map] = [OUTPOST,HIGHTOWER,SUBDIVISION,BOTTLENECK,NOESCAPE,SOLONG,LUNARCY,ICEBOX,SNOWBLIND,PYRAMID,CATACOMBS,OVERSEER,SUSPENSION,CLIFHANGER,CROSSFIRE,UNDERMINE]

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    

    
    @IBOutlet weak var btnGenerate: UIButton!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var exceptionTextFiled: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    var activeTextField: UITextField!
    
    var randomMaps:[Map?] = []
    var excludingMapIndexes:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultTableView.estimatedRowHeight = 56.0
        self.resultTableView.rowHeight = UITableViewAutomaticDimension
        self.title = "Map Generator"
        self.resultTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func generateRandomNumber(_ sender: UIButton) {
        
        if let txt:String = fromTextField.text,  let lower:Int =  Int(txt),let txt2 = toTextField.text, let uper:UInt32 = UInt32(txt2),let txt3:String = countTextField.text,  let count:Int =  Int(txt3) {
            
            self.randomMaps = self.uniqueRandoms(numberOfRandoms: count, minNum: lower, maxNum: uper, blackList: self.getExcludingNumbers()).map({ (index:Int) -> Map? in
                if let map:Map = Map.getMapFromIndex(index) {
                    return map
                }
                return nil
            })
            self.resultTableView.reloadData()
        }
        
        
    }
    func getExcludingNumbers() -> [Int] {
        var excluding:[Int] = []
        
        if let txt:String = self.exceptionTextFiled.text {
            let arr:[String] = txt.components(separatedBy: CharacterSet(charactersIn: "," ))
            for str:String in arr {
                if let inN:Int = Int(str) {
                    excluding.append(inN)
                }
            }
        }
        return excluding
        
    }
    func uniqueRandoms(numberOfRandoms: Int, minNum: Int, maxNum: UInt32, blackList: [Int] = []) -> [Int] {
        var randomNumbers = [Int]()
        
        for _ in 1...numberOfRandoms {
            var number = Int(arc4random_uniform(maxNum))+minNum
            while  randomNumbers.contains(number) || blackList.contains(number){
                number = Int(arc4random_uniform(16))+minNum
            }
            randomNumbers.append(number)
        }
        
        return randomNumbers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomMaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let miniMilitiaCell:MiniMilitiaCell = tableView.dequeueReusableCell(withIdentifier: "MiniMilitiaCell", for: indexPath) as! MiniMilitiaCell
        
        if let map:Map = self.randomMaps[indexPath.row] {
        
            miniMilitiaCell.mapName.text = map.name
            if let image = UIImage(named: map.name) {
                miniMilitiaCell.thumb?.image = image
                
            }
        }
       miniMilitiaCell.selectionStyle = .none
        return miniMilitiaCell
    }
    
}
extension Array {
    var shuffle:[Element] {
        var elements = self
        for index in 0..<elements.count {
            let anotherIndex = Int(arc4random_uniform(UInt32(elements.count-index)))+index
            if anotherIndex != index {
                elements.swapAt(index, anotherIndex)
            }
        }
        return elements
    }
}
@objc extension UITextField{
    
    @objc @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    @objc func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
