//
//  Dictionary+Ext.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/8/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit

extension Dictionary where Value: Comparable{
    var valueSorted: [(Key, Value)]{
        return sorted{if $0.value != $1.value{ return $0.value > $1.value}else{return true}}
    }
}
