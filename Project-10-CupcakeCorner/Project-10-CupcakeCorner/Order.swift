//
//  Order.swift
//  Project-10-CupcakeCorner
//
//  Created by Luca Capriati on 2022/08/31.
//

import SwiftUI

//  Project 10 - Challange 3:
@dynamicMemberLookup
class SharedOrder: ObservableObject {
    static let types = ["Vanialla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var data = Order()
    
    //  Project 10 - Challange 3:
    subscript<T>(dynamicMember keypath: KeyPath<Order, T>) -> T {
        data[keyPath: keypath]
    }
    
    subscript<T>(dynamicMember keypath: WritableKeyPath<Order, T>) -> T {
        get {
            data[keyPath: keypath]
        }
        
        set {
            data[keyPath: keypath] = newValue
        }
    }
}

//  Project 10 - Challange 3:
struct Order: Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, addExtraFrosting, addExtraSprinkles, name, streetAddress, city, zip
    }
    
    var type = 0
    var quantity = 3
    
    var addSpecialRequeset = false {
        // fixes a bug where if you enable extras and the disable request, the extras would remain.
        // ^ This fixes that.
        didSet {
            if addSpecialRequeset == false {
                addExtraFrosting = false
                addExtraSprinkles = false
            }
        }
    }
    
    var addExtraFrosting = false
    var addExtraSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        //  Project 10 - Challange 1:
        if name.isReallyEmpty || streetAddress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cake cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if addExtraFrosting {
            cost += Double(quantity)
        }
        
        // $0.5-/cake for extra sprinkles
        if addExtraSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}
