//
//  ApiRatesRepository.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ApiRatesRepository: ApiHttpRepository, RatesRepository {
    
    func getRatesList(completion: @escaping RatesArrayCompletion) {
        requestBuilder.getRates().responseArray { [weak self] (dataResponse: DataResponse<[Rate]>) in
            switch dataResponse.result {
            case .success:
                let rates = dataResponse.result.value
                completion(true, rates, nil)
            case .failure:
                completion(false, nil, self?.getError(from: dataResponse))
                return
            }
        }
    }
}
