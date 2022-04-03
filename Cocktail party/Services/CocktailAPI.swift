//
//  CocktailAPI.swift
//  Cocktail party
//
//  Created by APPLE on 01.04.2022.
//

import Foundation
import Alamofire

struct CocktailAPI {
    
    private let url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    
    func getJSON(completion:@escaping([Drink])->()) {
        
        DispatchQueue.main.async {
            AF.request(url).responseJSON { response in
                guard let response = response.data  else {return}
                
                do {
                    let response = try JSONDecoder().decode(CocktailResponse.self, from: response)
                    let drinks = response.drinks
                    completion(drinks)
                } catch {
                    print(error)
                }
            }
        }
    }
}
