//
//  HttpRequestBuilder.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class HttpRequestBuilder {
    
    func buildRequest(url: String, method: Alamofire.HTTPMethod) -> DataRequest {
        return buildRequest(url: url, method: method, params: [:])
    }
    
    func buildRequest(url: String, method: Alamofire.HTTPMethod, params: Mappable) -> DataRequest {
        return buildRequest(url: url, method: method, params: params.toJSON())
    }
    
    func buildRequest(url: String, method: Alamofire.HTTPMethod, params: Parameters) -> DataRequest {
        return buildRequest(manager: HttpManager.shared, url: url, method: method, params: params)
    }
    
    func buildRequest(manager: SessionManager, url: String, method: Alamofire.HTTPMethod, params: Parameters) -> DataRequest {
        return manager.request(getCompleteUrl(url: url), method: method, parameters: params, encoding: getEncoding(forMethod: method)).validate()
    }
    
    private func getCompleteUrl(url: String) -> String {
        return App.apiBaseUrl + url
    }
    
    private func getEncoding(forMethod method: Alamofire.HTTPMethod) -> ParameterEncoding {
        if method == .get {
            return URLEncoding.queryString
        } else {
            return Alamofire.JSONEncoding.default
        }
    }
}

