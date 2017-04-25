//
//  ViewController.swift
//  pokedex
//
//  Created by Md Munir Hossain on 4/25/17.
//  Copyright © 2017 Md Munir Hossain. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filtered_pokemons = [Pokemon]()
    var musicPlayer:AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV();
        initAudio()
    }
    func initAudio(){
        let soundPath = Bundle.main.path(forResource: "sound", ofType: "mp3")!
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: soundPath)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    @IBAction func music_pressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.2
        }else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do{
           let csv = try CSV(contentsOfURL: path)
           let rows = csv.rows
           for row in rows{
              let name = row["identifier"]!
              let id = Int(row["id"]!)!
            
              let poke = Pokemon(name: name, pokedexId: id)
              pokemons.append(poke)
            
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            let poke:Pokemon!
            if(inSearchMode){
                 poke = filtered_pokemons[indexPath.row]
            }else{
                 poke = pokemons[indexPath.row]
            }
            cell.configureCell(poke)
            return cell;
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
          return filtered_pokemons.count
        }
        return pokemons.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke:Pokemon!
        if(inSearchMode){
            poke = filtered_pokemons[indexPath.row]
        }else{
            poke = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailsVC", sender: poke)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        }else{
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filtered_pokemons = pokemons.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailsVC"{
            if let detailsVC = segue.destination as? PokemonDetailsVC{
                if let poke = sender as? Pokemon{
                    detailsVC.pokemon = poke
                }
            }
        }
    }
}





