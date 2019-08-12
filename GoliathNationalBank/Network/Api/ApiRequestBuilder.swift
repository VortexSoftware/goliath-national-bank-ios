//
//  ApiRequestBuilder.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import Alamofire

class ApiRequestBuilder: HttpRequestBuilder {
    
    func getRates() -> DataRequest {
        return buildRequest(url: ApiUrls.rates.rawValue, method: .get)
    }
    
    func getTransactions() -> DataRequest {
        return buildRequest(url: ApiUrls.transactions.rawValue, method: .get)
    }
}
