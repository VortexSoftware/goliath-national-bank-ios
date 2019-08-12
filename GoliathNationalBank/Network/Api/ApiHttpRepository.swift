//
//  ApiHttpRepository.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ApiHttpRepository {
    
    lazy var requestBuilder = ApiRequestBuilder()

    let defaultErrorMessage = "An error occurred. Please check your internet connection and try again."

    func getError<T: Mappable>(from response: DataResponse<[T]>) -> RepositoryError {
        if let responseData = response.data, let repositoryError = ApiRepositoryErrorParser.parse(from: responseData) {
            return repositoryError
        }
        return ApiRepositoryError(message: defaultErrorMessage)
    }
}
