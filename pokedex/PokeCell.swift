//
//  PokeCell.swift
//  pokedex
//
//  Created by Md Munir Hossain on 4/25/17.
//  Copyright © 2017 Md Munir Hossain. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        
    }
    
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
       thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
        nameLabel.text = self.pokemon.name.capitalized
    
    }
}
