//
//  ApiRepositoryErrorParser.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ApiRepositoryErrorParser {
    
    static func parse(from data: Data) -> ApiRepositoryError? {
        if let jsonString = String(data: data, encoding: String.Encoding.utf8) {
            let errorObject = ApiRepositoryError(JSONString: jsonString)
            return errorObject
        }
        return nil
    }
}
