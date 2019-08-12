//
//  ApiRepositoryError.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiRepositoryError: RepositoryError, Mappable {
    
    var message: String?

    init() { }
    
    init(message: String?) {
        self.message = message
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        message   <- map["error"]
    }
}
