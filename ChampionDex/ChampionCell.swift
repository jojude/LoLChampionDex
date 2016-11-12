//
//  ChampionCell.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/7/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit
import pop

class ChampionCell: UICollectionViewCell {
    
    @IBOutlet weak var championImage: UIImageView!
    @IBOutlet weak var champNameLbl: UILabel!
    
    var champion: Champion!
    
    func configureCell(_ champion: Champion){
        champNameLbl.text = champion.chamName.capitalized
        championImage.downloadedFrom(link: "http://ddragon.leagueoflegends.com/cdn/6.22.1/img/champion/\(champion.chamName).png")
    }
    
    //UI
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        //each view has a layer level to modify how it looks
        layer.cornerRadius = 5.0
        
    }
    
    func scaleToSmall(){
        //scale animation we want to run to a certain value
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 0.90, height: 0.90))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation(){
        //spring animation
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
    
    func scaleDefault(){
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize:CGSize(width: 1, height: 1))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleDefaultAnimation")
    }
    
}
