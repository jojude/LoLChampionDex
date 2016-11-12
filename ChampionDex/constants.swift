//
//  constants.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/7/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import Foundation

var BASE_URL = "http://ddragon.leagueoflegends.com/cdn/6.22.1/data/en_US/champion.json"
var URL_BASE_DESCRIPTION = "http://ddragon.leagueoflegends.com/cdn/6.22.1/data/en_US/champion/"
var URL_FULL_IMAGE_BASE = "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/"
var URL_SPELL_BASE = "http://ddragon.leagueoflegends.com/cdn/6.22.1/img/spell/"
var URL_PASSIVE_BASE = "http://ddragon.leagueoflegends.com/cdn/6.22.1/img/passive/"
var URL_FREE_TO_PLAY = "https://na.api.pvp.net/api/lol/na/v1.2/champion?freeToPlay=true&api_key=RGAPI-9b181de0-d985-4523-a474-443d4a345cb1"

typealias DownloadComplete = () -> ()
