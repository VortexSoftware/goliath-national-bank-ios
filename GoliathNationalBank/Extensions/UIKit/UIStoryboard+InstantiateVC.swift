//
//  UIStoryboard+InstantiateVC.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func instantiate(viewController viewControllerName: String) -> UIViewController {
        return UIStoryboard(name: viewControllerName, bundle: .main).instantiateViewController(withIdentifier: viewControllerName)
    }
}

