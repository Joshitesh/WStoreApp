//
//  WStoreListViewController.swift
//  W-StoreApp
//
//  Created by Hitesh Joshi on 11/08/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import UIKit

class WStoreListViewController: UITableViewController {
   var products = [WStoreProduct]()
    var spinner = UIActivityIndicatorView()
    var currentPage = 0
    var customView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        setupSpinner()
        fetchProducts()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: "wStoreListCell", for: indexPath) as? WStoreListViewCell{
            let product = products[indexPath.row]
            tableCell.configure(withProduct: product)
            return tableCell
        }
        return cell
    }

    /// Create Spinner
    func setupSpinner(){
        spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height:100))
        spinner.color = UIColor.black
        let frame = CGRect(x: tableView.contentSize.width/2, y: tableView.contentSize.height/2,
                           width: 40,
                           height: 40)
        self.spinner.frame = frame
        self.customView.addSubview(spinner)
        self.tableView.addSubview(customView)
        spinner.startAnimating()
    }

    /// Load data as soon as reach the bottom of table view
    ///
    /// - Parameter scrollView: scroll view
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            if scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging {
                setupSpinner()
                self.fetchProducts()
            }
            self.spinner.stopAnimating()
    }
    
    /// Fetch the products by making server call.
    func fetchProducts(){
        WStoreDataManager.getProducts(page: currentPage) { products in
            DispatchQueue.main.async {
                 if !products.isEmpty {
                    self.products += products
                    self.currentPage += 1
                }
                self.spinner.stopAnimating()
                self.tableView.reloadData()
            }
        }
    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let pdvc = segue.destination as? WStoreDetailController {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let selectedProduct = products[indexPath.row]
                    pdvc.product = selectedProduct
                }
            }
        }
    }
 

}
