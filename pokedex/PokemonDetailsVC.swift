//
//  PokemonDetailsVC.swift
//  pokedex
//
//  Created by Md Munir Hossain on 4/25/17.
//  Copyright © 2017 Md Munir Hossain. All rights reserved.
//

import UIKit
class PokemonDetailsVC: UIViewController {
    var pokemon: Pokemon!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var nexrEvoImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var heightLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTitle.text = pokemon.name.capitalized
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        pokedexLbl.text = "\(pokemon.pokedexId)"

        pokemon.downloadPokemonDetails {
            //do your code after download is completed
            
            self.updateUI()
            
        }
    }
    
    func updateUI(){
        weightLbl.text = pokemon.weight
        defenseLbl.text = pokemon.defense
        attackLbl.text = pokemon.attack
        heightLbl.text = pokemon.height
        typeLbl.text = pokemon.type
        nameLbl.text = pokemon.description
        
        if pokemon.nextEvoLevel == ""{
            evoLbl.text = "No Evolution"
            nexrEvoImg.isHidden = true
        }else{
            nexrEvoImg.isHidden = false
            evoLbl.text = "Next Evoulution: \(pokemon.nextEvoName) LVL \(pokemon.nextEvoLevel)"
            nexrEvoImg.image = UIImage(named: "\(pokemon.nextEvoId)")

        }
    }

  
    @IBAction func btn_back_pressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
