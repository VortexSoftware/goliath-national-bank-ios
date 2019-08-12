//
//  RatesRepository.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation

protocol RatesRepository {
    
    typealias RatesArrayCompletion = (_ success: Bool, _ result: [Rate]?, _ error: RepositoryError?) -> Void
    
    func getRatesList(completion: @escaping RatesArrayCompletion)
}
