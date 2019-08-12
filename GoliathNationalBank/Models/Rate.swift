//
//  Rate.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import ObjectMapper

class Rate: Mappable {
    
    var from: String?
    var to: String?
    var rate: NSDecimalNumber?
    
    init() { }
    
    init(from: String?, to: String?, rate: NSDecimalNumber?) {
        self.from = from
        self.to = to
        self.rate = rate
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        from <- map["from"]
        to <- map["to"]
        rate <- (map["rate"], NSDecimalNumberTransform())
    }
}
