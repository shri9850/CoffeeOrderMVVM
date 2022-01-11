//
//  AddOrderViewModel.swift
//  CoffeeOrderNewMVVM
//
//  Created by shree on 11/01/22.
//

import Foundation
struct AddOrderViewModel {
    var name: String?
    var email: String?
    var types: [String]{
        return CoffeeType.allCases.map{ $0.rawValue.capitalized}
    }
    var sizes: [String]{
        return CoffeeSize.allCases.map{ $0.rawValue.capitalized}
    }
    
    var selectedSize: String?
    var selectedType: String?
}
