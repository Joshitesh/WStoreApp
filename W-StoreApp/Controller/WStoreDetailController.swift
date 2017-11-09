//
//  WStoreDetailController.swift
//  W-StoreApp
//
//  Created by Hitesh Joshi on 11/08/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import UIKit

class WStoreDetailController: UITableViewController {

    var product: WStoreProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailViewCell", for: indexPath) as? WStoreDetailViewCell
        if let prod = self.product{
            cell?.configure(withProduct: prod)
        }
        return cell!
    }

}
