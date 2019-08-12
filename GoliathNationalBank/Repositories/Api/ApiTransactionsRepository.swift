//
//  ApiTransactionsRepository.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ApiTransactionsRepository: ApiHttpRepository, TransactionsRepository {
    
    func getTransactionsList(completion: @escaping TransactionsArrayCompletion) {
        requestBuilder.getTransactions().responseArray { [weak self] (dataResponse: DataResponse<[Transaction]>) in
            switch dataResponse.result {
            case .success:
                let transactions = dataResponse.result.value
                completion(true, transactions, nil)
            case .failure:
                completion(false, nil, self?.getError(from: dataResponse))
                return
            }
        }
    }
}
