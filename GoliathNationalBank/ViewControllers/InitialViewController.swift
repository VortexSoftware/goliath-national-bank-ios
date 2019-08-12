//
//  InitialViewController.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = ProductsListWireframe.getViewController()
        navigationController?.setViewControllers([vc], animated: true)
    }
}
