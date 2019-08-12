//
//  Transaction.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import ObjectMapper

class Transaction: Mappable {
    
    var sku: String?
    var currency: String?
    var amount: NSDecimalNumber?
    
    init() { }
    
    init(sku: String?, currency: String?, amount: NSDecimalNumber?) {
        self.sku = sku
        self.currency = currency
        self.amount = amount
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        sku <- map["sku"]
        currency <- map["currency"]
        amount <- (map["amount"], NSDecimalNumberTransform())
    }
}
