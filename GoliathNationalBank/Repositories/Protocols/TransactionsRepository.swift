//
//  TransactionsRepository.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation

protocol TransactionsRepository {
    
    typealias TransactionsArrayCompletion = (_ success: Bool, _ result: [Transaction]?, _ error: RepositoryError?) -> Void
    
    func getTransactionsList(completion: @escaping TransactionsArrayCompletion)
}
