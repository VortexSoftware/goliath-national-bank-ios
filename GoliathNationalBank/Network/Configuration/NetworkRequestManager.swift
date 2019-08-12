//
//  NetworkRequestManager.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import Alamofire
import Reqres

class NetworkRequestManager { }

extension NetworkRequestManager: RequestAdapter {
    // Sets application/json as the accepted content type
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
