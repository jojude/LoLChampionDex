//
//  DetailVC.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/7/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit

class DetailVC: UIViewController{
    
    var champion: Champion!    
    var ability: Int!
    var attack: Int!
    var defense: Int!
    var difficulty: Int!
    var skillImages = [UIImageView]()
    var i = 1
    var showskins = true

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var primaryRole: UILabel!
    @IBOutlet weak var secondaryRole: UILabel!
    @IBOutlet weak var passiveImage: UIImageView!
    @IBOutlet weak var qSkill: UIImageView!
    @IBOutlet weak var wSkill: UIImageView!
    @IBOutlet weak var eSkill: UIImageView!
    @IBOutlet weak var rSkill: UIImageView!
    @IBOutlet weak var fullImage: UIImageView!
    
    @IBOutlet weak var attackProgressBar: CustomProgressBar!
    @IBOutlet weak var defenseProgressBar: CustomProgressBar!
    @IBOutlet weak var magicProgressBar: CustomProgressBar!
    @IBOutlet weak var difficultyProgressBar: CustomProgressBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up initial view
        self.titleLbl.text = champion.chamName
        self.fullImage.downloadedFrom(link: "\(URL_FULL_IMAGE_BASE)\(champion.chamName)_0.jpg")
        self.initProgressBars()
        
        //after data is downloaded set up images and ui
        champion.downloadChampionData {
            self.updateUI()
            self.setupForTrasition(images: self.skillImages)
            self.animateProgressBar()
            self.showSkins()
        }

    }
    
    func updateUI(){
        
        self.nickname.text = champion.title.capitalized
        self.primaryRole.text = champion.primaryRole.capitalized
        self.secondaryRole.text = champion.secondaryRole.capitalized
        
        self.passiveImage.downloadedFrom(link:"\(URL_PASSIVE_BASE)\(champion.champPassive)")
        self.qSkill.downloadedFrom(link: "\(URL_SPELL_BASE)\(champion.skills[0])")
        self.wSkill.downloadedFrom(link: "\(URL_SPELL_BASE)\(champion.skills[1])")
        self.eSkill.downloadedFrom(link: "\(URL_SPELL_BASE)\(champion.skills[2])")
        self.rSkill.downloadedFrom(link: "\(URL_SPELL_BASE)\(champion.skills[3])")
        
        skillImages.append(passiveImage)
        skillImages.append(qSkill)
        skillImages.append(wSkill)
        skillImages.append(eSkill)
        skillImages.append(rSkill)
        
        ability = champion.magicDamage
        attack = champion.attack
        defense = champion.defense
        difficulty = champion.difficulty
    }
    
    //-------------------------------CHAMPION SKIN UX-------------------------------------------//
    // Gets next skin for Champion
    func showSkins(){
        if self.showskins{
            if i <= champion.skinCount{
                changeSkin(i: i)
                i += 1
            }else{
                i = 0
                changeSkin(i: i)
            }
        }
    }
    
    //change skin with dissolve animation
    func changeSkin(i: Int){
        UIView.transition(with: self.fullImage,
                          duration:5,
                          options: UIViewAnimationOptions.transitionCrossDissolve,
                          animations: { self.fullImage.downloadedFrom(link: "\(URL_FULL_IMAGE_BASE)\(self.champion.chamName)_\(i).jpg") },
                          completion: {(true) -> Void in
                            self.showSkins()
                        })
    }
    
      //------------------------------Progress Bar Anim-------------------------------------------//
    
    func initProgressBars(){
        self.attackProgressBar.progress = 0.0
        self.defenseProgressBar.progress = 0.0
        self.magicProgressBar.progress = 0.0
        self.difficultyProgressBar.progress = 0.0
    }
    
    func animateProgressBar(){
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when, execute: {
            self.attackProgressBar.setProgress(Float(self.attack)/10.0, animated: true)
            self.defenseProgressBar.setProgress(Float(self.defense)/10.0, animated: true)
            self.magicProgressBar.setProgress(Float(self.ability)/10.0, animated: true)
            self.difficultyProgressBar.setProgress(Float(self.difficulty)/10.0, animated: true)
        })
    }
    
    //---------------------Back Button-------------------//

    @IBAction func backButtonPressed(_ sender: Any) {
        self.showskins = false
        i = 1
        dismiss(animated: true, completion: nil)
    }
    
    //------------------------------SKILL TRANSITION-------------------------------------//
    
    func setupForTrasition(images: [UIImageView]){
        var i = 0
        
        for image in images{
            image.tag = i
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailVC.didTapImageView(_:))))
            i += 1
        }
    }
    
    func didTapImageView(_ tap: UITapGestureRecognizer) {
        if let index = tap.view?.tag{
            let skill = skillImages[index]
                //present details view controller
                let vc = storyboard?.instantiateViewController(withIdentifier: "infoVC") as? testVC
                vc?.newSkill = skill.image
                vc?.descript = champion.skillDescription[index]
                vc?.skillName = champion.skillName[index]
            if index == 0{
                vc?.isPassive = true
            }else{
                let i = index - 1
                vc?.isPassive = false
                vc?.effectBurn = champion.skillEffectBurn[i]
                vc?.costType = champion.skillCostType[i]
                vc?.costBurn = champion.skillCostBurn[i]

            }
                vc?.transitioningDelegate = self
                vc?.modalPresentationStyle = .custom
                present(vc!, animated: true, completion: nil)
        }
    }
    
    
}

//--------------Transition Delegate Functions --------------------------------------------//

extension DetailVC: UIViewControllerTransitioningDelegate{
    
     func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
     
            return popAnimation()
     }
     
     func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
            return dismissAnimation()
     }
    
}

