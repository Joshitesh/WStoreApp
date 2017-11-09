//
//  WStoreDetailViewCell.swift
//  W-StoreApp
//
//  Created by Hitesh Joshi on 11/08/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import UIKit

class WStoreDetailViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productShortDescription: UILabel!
    @IBOutlet weak var productLongDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRatingReview: UILabel!
    
    func configure(withProduct product: WStoreProduct){
            WStoreDataManager.getProductImage(at: product.imageURL) { image in
                DispatchQueue.main.async {
                    self.productImage?.image = image
                }
            }
            self.productName.text = product.name
            let htmlString = product.shortDescription
            let attributed = try! NSAttributedString(data: htmlString.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            self.productShortDescription.text = attributed.string
            let htmlString1 = product.longDescription
            let attributed1 = try! NSAttributedString(data: htmlString1.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            self.productLongDescription.text = attributed1.string
            self.productPrice.text = product.priceAndStockText
            self.productRatingReview.text = product.ratingText
        }
}
