//
//  WStoreListViewCell.swift
//  W-StoreApp
//
//  Created by Hitesh Joshi on 11/08/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import UIKit

class WStoreListViewCell: UITableViewCell {
    
    @IBOutlet weak var wStoreListImageView: UIImageView!
    @IBOutlet weak var wStoreItemfeedback: UILabel!
    @IBOutlet weak var wStoreItemPrice: UILabel!
    @IBOutlet weak var wStoreItemDescprition: UILabel!

    func configure(withProduct product: WStoreProduct) {
        accessoryType = .disclosureIndicator
        wStoreItemDescprition?.text = product.name
        wStoreItemPrice?.text = product.priceAndStockText
        wStoreItemfeedback?.text = product.ratingText
        WStoreDataManager.getProductImage(at: product.imageURL) { image in
            DispatchQueue.main.async {
                self.wStoreListImageView?.image = image
            }
        }
    }

}
