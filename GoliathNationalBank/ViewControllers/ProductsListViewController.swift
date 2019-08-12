//
//  ProductsListViewController.swift
//  GoliathNationalBank
//
//  Created by Gastón Sobrevilla on 11/08/2019.
//  Copyright © 2019 Goliath National Bank. All rights reserved.
//

import Foundation
import UIKit

class ProductsListViewController: UIViewController {
    
    var viewModel: ProductsListViewModel?
    
    @IBOutlet private var tableView: UITableView?
    lazy private var loadingOverlay = LoadingOverlay()
    
    private var items: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "GNB Products"
    }
    
    private func setupTableView() {
        guard let tableView = tableView else { return }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func fetchData() {
        loadingOverlay.show(over: view)
        viewModel!.fetchProductsList()
    }
}

extension ProductsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = item.sku
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        viewModel?.fetchDetailFor(sku: item.sku)
    }
}

extension ProductsListViewController: ProductsListViewProtocol {
    
    func updateProductsList(products: [Product]) {
        loadingOverlay.hide()
        items = products
        tableView?.reloadData()
    }
    
    func updateProductDetail(product: Product) {
        if let detailVC = ProductDetailViewController.instantiateFromStoryboard() as? ProductDetailViewController {
            detailVC.product = product
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func showError(message: String?) {
        loadingOverlay.hide()
        showOkDialog(title: "Error", message: message)
    }
}
