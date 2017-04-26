//
//  Pokemon.swift
//  pokedex
//
//  Created by Md Munir Hossain on 4/25/17.
//  Copyright © 2017 Md Munir Hossain. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolutionTxt:String!
    private var details_URL: String!
    
    private var _nextEvoId: String!
    private var _nextEvoName: String!
    private var _nextEvoLevel: String!
    
    
    var nextEvoId: String{
        if _nextEvoId == nil{
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoName: String{
        if _nextEvoName == nil{
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    var nextEvoLevel: String{
        if _nextEvoLevel == nil{
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    var name: String{
        if _name == nil{
            _name = ""
        }
        return _name
    }
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    var nextEvolutionTxt: String{
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(name: String,pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self.details_URL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        //print(self.details_URL)
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadCompleted){
        Alamofire.request(self.details_URL).responseJSON { response in
            print(response.request ?? "request no value")  // original URL request
            print(response.response ?? "response no value") // HTTP URL response
            print(response.data ?? "data no value")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                if let dict = JSON as? Dictionary<String, AnyObject>{
                    if let weight = dict["weight"] as? String{
                        self._weight = weight
                    }
                    
                    if let height = dict["height"] as? String{
                        self._height = height
                    }
                    
                    if let attack = dict["attack"] as? Int{
                        self._attack = "\(attack)"
                    }
                    
                    if let defense = dict["defense"] as? Int{
                        self._defense = "\(defense)"
                    }
                    
                    if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0{
                        if let name = types[0]["name"]{
                          self._type = name
                        }
                        //more then one type
                        if types.count > 1{
                            for x in 1..<types.count{
                                if let name = types[x]["name"]{
                                    self._type! += "/\(name.capitalized)"
                                }
                            }
                        }
                    }else{
                        self._type = ""
                    }
                    
                    //print(self.weight)
                    //print(self.defense)
                    //print(self.height)
                    //print(self.attack)
                    
                    
                    if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] , descriptions.count > 0{
                        if let resource_uri = descriptions[0]["resource_uri"]{
                                let desURL = "\(URL_BASE)\(resource_uri)"
                                Alamofire.request(desURL).responseJSON { response in                                    
                                    if let dict = response.result.value as? Dictionary<String, AnyObject>{
                                        if let des = dict["description"] as? String{
                                            let newDes = des.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                            self._description = newDes
                                        }
                                    }
                                    completed()

                                }
                            
                        }
                    }
                    
                    
                    if let evoulutions = dict["evolutions"] as? [Dictionary<String,AnyObject>], evoulutions.count > 0{
                        if let nextLevel = evoulutions[0]["level"] as? Int{
                            self._nextEvoLevel = "\(nextLevel)"
                            if let nextEvo = evoulutions[0]["to"] as? String{
                                self._nextEvoName = nextEvo
                            }
                            if let nextEvoURI = evoulutions[0]["resource_uri"] as? String{
                                let tempURI = nextEvoURI.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextLevelID = tempURI.replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = nextLevelID

                            }
                        }else{
                            self._nextEvoLevel = ""
                        }
                    }
                    
                    
                }
            }
        }
    }

}
