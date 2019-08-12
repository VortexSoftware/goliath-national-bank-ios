//
//  ProductsListWireframe.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import UIKit

class ProductsListWireframe {
    
    static func getViewController() -> UIViewController {
        let transactionsRepository = ApiTransactionsRepository()
        let ratesRepository = ApiRatesRepository()
        let vc = ProductsListViewController.instantiateFromStoryboard() as! ProductsListViewController
        let viewModel = ProductsListViewModel(view: vc, transactionsRepository: transactionsRepository, ratesRepository: ratesRepository)
        vc.viewModel = viewModel
        return vc
    }
}
