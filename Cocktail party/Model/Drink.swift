//
//  CocktailModel.swift
//  Cocktail party
//
//  Created by APPLE on 01.04.2022.
//

import Foundation


struct CocktailResponse: Codable {
    public  let drinks: [Drink]
}

struct Drink: Codable {
    public let strDrink: String
    public let strDrinkThumb: String
    public let idDrink: String
    public var isSelected: Bool? = false
}

class DrinkViewModel {
    var text: String
    var isSelected: Bool
    
    init(text: String, isSelected: Bool) {
        self.text = text
        self.isSelected = isSelected
    }
}
