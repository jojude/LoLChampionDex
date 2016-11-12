//
//  Champion.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/7/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import Foundation
import Alamofire

class Champion{
    
    private var _name: String!
    private var _key: String!
    private var _description: String!
    private var _title: String!
    
    private var _passive: String!
    private var _passiveDescription: String!
    private var _primaryRole: String!
    private var _secondaryRole: String!
    
    private var _defense: Int!
    private var _attack: Int!
    private var _magicDamage: Int!
    private var _difficult: Int!
    
    private var _skills = [String!]()
    private var _skillNames = [String!]()
    private var _skillCostType = [String!]()
    private var _skillCostBurn = [String!]()
    private var _skillEffectBurn = [String!]()
    private var _skillDescription = [String!]()
    private var _skinCount: Int!

    
    private var _championURL: String!
    
    // data storage
    var skillEffectBurn: [String]{
        return _skillEffectBurn
    }
    
    var skillCostBurn: [String]{
        return _skillCostBurn
    }
    
    var skillCostType:[String]{
        return _skillCostType
    }
    
    var skillName: [String]{
        if _skillNames == []{
            _skillNames = []
        }
        return _skillNames
    }
    
    var skillDescription: [String]{
        if _skillDescription == []{
            _skillDescription = []
        }
        return _skillDescription
    }
    
    var skinCount: Int{
        if _skinCount == nil{
            _skinCount = 0
        }
        return _skinCount
    }
    
    var skills: [String]{
        if _skills == []{
            _skills = []
        }
        return _skills
    }

    
    var secondaryRole: String{
        if _secondaryRole == nil{
            _secondaryRole = ""
        }
        return _secondaryRole
    }
    
    var primaryRole: String{
        if _primaryRole == nil{
            _primaryRole = ""
        }
        return _primaryRole
    }
    
    var title: String{
        if _title == nil{
            _title = ""
        }
        return _title
    }
    
    var chamName: String{
        if _name == nil{
            _name = ""
        }
        return _name
    }
    
    var champDescription: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var champPassive: String{
        if _passive == nil{
            _passive = ""
        }
        return _passive
    }
    
    var defense: Int{
        if _defense == nil{
            _defense = 0
        }
        return _defense
    }
    
    var attack: Int{
        if _attack == nil{
            _attack = 0
        }
        return _attack
    }
    
    var magicDamage: Int{
        if _magicDamage == nil{
            _magicDamage = 0
        }
        return _magicDamage
    }
    
    var difficulty: Int{
        if _difficult == nil{
            _difficult = 0
        }
        return _difficult
    }
    
    var passiveDescription: String{
        if _passiveDescription == nil{
            _passiveDescription = ""
        }
        return _passiveDescription
    }
    //--------------------------------
    
    init(name: String, key: String){
        self._name = name
        self._key = key
        self._championURL = "\(URL_BASE_DESCRIPTION)\(_name).json"
    }
    
    //lazy loading data
    func downloadChampionData(completed: @escaping DownloadComplete){
        print("downloading data")
        
        let chmpKey = self._key!
        
        let url = "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/\(chmpKey)?champData=all&api_key=YOUR_API_KEY_HERE"
        
        Alamofire.request(url).responseJSON { (response) in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                if let chmpTitle = json["title"] as? String{
                    self._title = chmpTitle
                }
                
                if let tags = json["tags"] as? [String]{
                    if tags.count > 1{
                        self._primaryRole = tags[0]
                        self._secondaryRole = tags[1]
                    }else{
                        self._primaryRole = tags[0]
                        self._secondaryRole = "NONE"
                    }
                }
                
                if let skin = json["skins"] as? [Dictionary<String, AnyObject>]{
                    self._skinCount = skin.count - 1
                }
                
                if let info = json["info"] as? Dictionary<String, Int>{
                    if let attack = info["attack"]{
                        self._attack = attack
                    }
                    if let defense = info["defense"]{
                        self._defense = defense
                    }
                    if let magic = info["magic"]{
                        self._magicDamage = magic
                    }
                    if let difficult = info["difficulty"]{
                        self._difficult = difficult
                    }
                }
                
                if let passive = json["passive"] as? Dictionary<String, AnyObject>{
                    if let name = passive["name"] as? String{
                        self._skillNames.append(name)
                    }
                    
                    if let image = passive["image"] as? Dictionary<String, AnyObject>{
                        if let imageURL = image["full"] as? String{
                            self._passive = imageURL
                        }
                    }
                    if let description = passive["description"] as? String{
                        self._skillDescription.append(description)
                    }
                }
                
                if let spells = json["spells"] as? [Dictionary<String, AnyObject>]{
                    for spell in spells{
                        if let name = spell["name"] as? String{
                            self._skillNames.append(name)
                        }
                        if let costType = spell["costType"] as? String{
                            self._skillCostType.append(costType)
                        }
                        if let costBurn = spell["costBurn"] as? String{
                            self._skillCostBurn.append(costBurn)
                        }
                        if let effectBurn = spell["effectBurn"] as? [String]{
                            self._skillEffectBurn.append(effectBurn[1])
                        }
                        if let image = spell["image"] as? Dictionary<String, AnyObject>{
                            if let imageURL = image["full"] as? String{
                                self._skills.append(imageURL)
                            }
                        }
                        if let description = spell["description"] as? String{
                            self._skillDescription.append(description)
                        }
                    }
                }
            }
            completed()
        }
    }
    
    
    
}
