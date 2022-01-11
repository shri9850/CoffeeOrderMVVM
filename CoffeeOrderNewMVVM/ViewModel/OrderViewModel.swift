//
//  OrderViewModel.swift
//  CoffeeOrderNewMVVM
//
//  Created by shree on 11/01/22.
//

import Foundation
struct OrderViewModel {
    let order: Order
}
extension OrderViewModel{
    var name:String{
        return order.name
    }
    var email: String{
        return order.email
    }
    var type: String{
        return order.type.rawValue.capitalized
    }
    var size: String{
        return order.size.rawValue.capitalized
    }
}

struct OrderListViewModel {
    var orderArray: [OrderViewModel]
}
extension OrderListViewModel{
    init() {
        self.orderArray = [OrderViewModel]()
    }
}
