//
//  ProductDetailViewController.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet private var totalLabel: UILabel?
    @IBOutlet private var tableView: UITableView?
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Transactions for \(product?.sku ?? "")"
        totalLabel?.text = "\(product?.total?.stringValue ?? "") EUR"
    }
    
    private func setupTableView() {
        guard let tableView = tableView else { return }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product?.transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = product?.transactions?[indexPath.row] else {
            return UITableViewCell()
        }

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(item.amount?.stringValue ?? "") \(item.currency ?? "")"
        return cell
    }
}

