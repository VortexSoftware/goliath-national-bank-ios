//
//  HttpManager.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import Reqres
import Alamofire

class HttpManager: Alamofire.SessionManager {
    
    static let shared: HttpManager = {
        let configuration = Reqres.defaultSessionConfiguration()
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        let manager = HttpManager(configuration: configuration)
        manager.adapter = NetworkRequestManager()
        return manager
    }()
}
