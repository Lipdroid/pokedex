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
    
    @IBOutlet weak var nameTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTitle.text = pokemon.name.capitalized
    }

  
    @IBAction func btn_back_pressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
