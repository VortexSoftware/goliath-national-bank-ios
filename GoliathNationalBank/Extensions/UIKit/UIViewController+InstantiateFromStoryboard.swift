//
//  UIViewController+InstantiateFromStoryboard.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func instantiateFromStoryboard() -> UIViewController {
        return UIStoryboard.instantiate(viewController: String(describing: self))
    }
}
