//
//  ViewController.swift
//  ChampionDex
//
//  Created by Jude Joseph on 11/6/16.
//  Copyright © 2016 Jude Joseph. All rights reserved.
//

import UIKit
import AVFoundation
import Spring

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var champions = [Champion]()
    var filteredChampions = [Champion]()
    var freeToPlay = [Int]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parseChampions()
        initAudio()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func initAudio(){
        
        let path = Bundle.main.path(forResource: "bw_gangplank", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            //set continuous loop
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let champ : Champion!
        print("selected")
        
        let cell = collectionView.cellForItem(at: indexPath) as? ChampionCell
        cell?.scaleAnimation()
        
        if inSearchMode{
            champ = filteredChampions[indexPath.row]
        }else{
            champ = champions[indexPath.row]
        }
        
        let when = DispatchTime.now() + 1.0
        
            DispatchQueue.main.asyncAfter(deadline: when, execute:{
                self.performSegue(withIdentifier: "ChampionSelected", sender: champ)
            })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChampionSelected"{
            if let detailsVC = segue.destination as? DetailVC{
                if let champ = sender as? Champion{
                    detailsVC.champion = champ
                }
            }
        }
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChampionCell", for: indexPath) as? ChampionCell{
            
            let champ : Champion!
            if inSearchMode{
                champ = filteredChampions[indexPath.row]
            }else{
                champ = champions[indexPath.row]
            }
            
            cell.configureCell(champ)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return filteredChampions.count
        }
        
        return champions.count
    }
    
    
    func parseChampions(){
        
        let champs = ["35": "Shaco", "36": "DrMundo","33": "Rammus","34": "Anivia", "39": "Irelia","157": "Yasuo","37": "Sona","38": "Kassadin", "154": "Zac","150": "Gnar","43": "Karma","42": "Corki","41": "Gangplank","40":"Janna","202": "Jhin","203": "Kindred","201": "Braum","22": "Ashe","23": "Tryndamere","24": "Jax","25": "Morgana","26": "Zilean","27": "Singed", "28": "Evelynn","29": "Twitch","161": "Velkoz","3": "Galio", "2": "Olaf","163": "Taliyah","1": "Annie","7": "Leblanc","30": "Karthus","6": "Urgot","5": "XinZhao","32": "Amumu","4": "TwistedFate","31": "Chogath","9": "FiddleSticks","8": "Vladimir","19": "Warwick","17": "Teemo","18": "Tristana","15": "Sivir","16": "Soraka", "13": "Ryze","14": "Sion","11": "MasterYi","12": "Alistar","21": "MissFortune", "20": "Nunu","107": "Rengar", "106": "Volibear","105": "Fizz","104": "Graves", "103": "Ahri","102": "Shyvana", "99": "Lux","101": "Xerath","412": "Thresh","98": "Shen","222": "Jinx", "96": "KogMaw","223": "TahmKench","92": "Riven","91": "Talon","90": "Malzahar","427": "Ivern", "10": "Kayle","429": "Kalista", "421": "RekSai","420": "Illaoi","89": "Leona","79": "Gragas","117": "Lulu","78": "Poppy","114": "Fiora","77": "Udyr", "115": "Ziggs","240": "Kled","112": "Viktor","113": "Sejuani","110": "Varus", "111": "Nautilus","119": "Draven", "432": "Bard","82": "Mordekaiser","245": "Ekko","83": "Yorick","80": "Pantheon", "81": "Ezreal","86": "Garen", "84": "Akali","85": "Kennen","67": "Vayne","126": "Jayce","69": "Cassiopeia","127": "Lissandra", "68": "Rumble","121": "Khazix","122": "Darius","120": "Hecarim","72": "Skarner","236": "Lucian","74": "Heimerdinger","75": "Nasus","238": "Zed","76": "Nidalee","134": "Syndra","59": "JarvanIV", "133": "Quinn","58": "Renekton","57": "Maokai","136": "AurelionSol","56": "Nocturne","55": "Katarina", "64": "LeeSin","62": "MonkeyKing","63": "Brand","268": "Azir","60": "Elise","131": "Diana","267": "Nami","61": "Orianna","266": "Aatrox","143": "Zyra", "48": "Trundle","45": "Veigar","44": "Taric","51": "Caitlyn","53": "Blitzcrank","54": "Malphite","254": "Vi","50": "Swain"]
        
        
        //print(champs)
        for champ in champs{
            let champion = Champion(name: champ.value, key: champ.key)
            champions.append(champion)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
            
        }else{
            inSearchMode = true
            
            let lower = searchBar.text
            
            filteredChampions = champions.filter({$0.chamName.range(of: lower!) != nil })
            collectionView.reloadData()
            
        }
    }

    
}

