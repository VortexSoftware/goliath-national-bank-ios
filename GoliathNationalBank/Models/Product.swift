//
//  Product.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation

class Product {
    
    let sku: String
    let total: NSDecimalNumber?
    let transactions: [Transaction]?
    
    init(sku: String, total: NSDecimalNumber? = nil, transactions: [Transaction]? = nil) {
        self.sku = sku
        self.total = total
        self.transactions = transactions
    }
}
