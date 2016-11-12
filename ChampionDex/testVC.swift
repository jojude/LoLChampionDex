//
//  testVC.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/10/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit

class testVC: UIViewController {
    
    @IBOutlet weak var skillNameLbl: UILabel!
    @IBOutlet weak var skillDescription: UILabel!
    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var costTypeLbl: UILabel!
    @IBOutlet weak var costBurnLbl: UILabel!
    @IBOutlet weak var effectBurnLbl: UILabel!
    @IBOutlet weak var costTypeTitleLbl: UILabel!
    
    var newSkill: UIImage!
    var descript = ""
    var skillName = ""
    var costBurn = ""
    var costType = ""
    var effectBurn = ""
    var isPassive = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.layer.cornerRadius = 5.0
        outlineView.layer.cornerRadius = 5.0
        self.image.image = newSkill
        self.skillDescription.text = descript
        self.skillNameLbl.text = skillName
        
        if isPassive{
            self.costTypeLbl.text = "NoCost"
            self.costBurnLbl.text = "none"
            self.effectBurnLbl.text = "none"
            self.costTypeTitleLbl.text = "Passive"
        }else{
            self.costTypeTitleLbl.text = "Cost Type"
            self.costTypeLbl.text = costType
            self.costBurnLbl.text = costBurn
            self.effectBurnLbl.text = effectBurn
        }
    }
    
    @IBAction func dissmissButtonSelected(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
