//
//  CustomImageView.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/8/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    @IBInspectable var cornerRadius : CGFloat = 5.0{
        didSet{
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = 5.0
        self.contentMode = UIViewContentMode.scaleAspectFill;
        self.layer.masksToBounds = true
    }
    
    func presentMoveDetails(currentVC: DetailVC){
        
        currentVC.view.tintAdjustmentMode = .dimmed
        currentVC.view.isUserInteractionEnabled = false
        
        let dimmingView = UIView(frame: currentVC.view.bounds)
        dimmingView.backgroundColor = UIColor.darkGray
        dimmingView.layer.opacity = 0.0
        
        let customView = UIView(frame: CGRect(x: 0, y: 0,  width: currentVC.view.bounds.width - 104.0, height: currentVC.view.bounds.height - 288.0))
        customView.layer.cornerRadius = 5.0
    }

}
