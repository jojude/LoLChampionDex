//
//  CustomProgressBar.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/7/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit

class CustomProgressBar: UIProgressView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var barHeight : CGFloat = 5.0{
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 3.0{
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
        self.transform = CGAffineTransform(scaleX: 1, y: 3)
        self.layer.cornerRadius = 3.0
    }
}
