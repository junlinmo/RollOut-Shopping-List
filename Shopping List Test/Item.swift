//
//  Item.swift
//  Shopping List Test
//
//  Created by Junlin Mo on 8/25/18.
//  Copyright © 2018 Junlin Mo. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    init(name: String, price: Float) {
        super.init()
        
        self.name = name
        self.price = price
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(uuid, forKey: "uuid")
        coder.encode(name, forKey: "name")
        coder.encode(price, forKey: "price")
        coder.encode(inShoppingList, forKey: "inShoppingList")
    }
    
    
    required init?(coder decoder: NSCoder) {
        super.init()
        
        if let archivedUuid = decoder.decodeObject(forKey: "uuid") as? String {
            uuid = archivedUuid
        }
        
        if let archivedName = decoder.decodeObject(forKey: "name") as? String {
            name = archivedName
        }
        
        price = decoder.decodeFloat(forKey: "price")
        inShoppingList = decoder.decodeBool(forKey: "inShoppingList")
    }
    

    var uuid: String = NSUUID().uuidString
    var name: String = ""
    var price: Float = 0.0
    var inShoppingList = false
}
