//
//  Order.swift
//  CoffeeOrderNewMVVM
//
//  Created by shree on 11/01/22.
//

import Foundation
enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case lattee
    case espressino
    case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}
extension Order{
    static var create: Resources<[Order]> = {
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {  fatalError("Bad URL") }
        return Resources<[Order]>(url: url)
    }()
    static func addOrder(order: AddOrderViewModel)->Resources<Order?>{
        let order = Order(order)
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {  fatalError("Bad URL") }
        let data = try? JSONEncoder().encode(order)
        var resources = Resources<Order?>(url: url)
        resources.data = data
        resources.method = .post
        return resources
    }
}
extension Order{
    init(_ Vm: AddOrderViewModel){
        self.name = Vm.name ?? ""
        self.email = Vm.email ?? ""
        self.type = CoffeeType(rawValue: Vm.selectedType!.lowercased())!
        self.size = CoffeeSize(rawValue: Vm.selectedSize!.lowercased())!
    }
}
