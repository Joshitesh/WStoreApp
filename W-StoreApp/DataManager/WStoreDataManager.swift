//
//  WStoreDataManager.swift
//  W-StoreApp
//
//  Created by Hitesh Joshi on 11/08/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import UIKit

class WStoreDataManager: NSObject {
    
    static func getProducts(page: Int, completion: @escaping ([WStoreProduct]) -> Void) {
        let pageSize = 20
        guard let url = URL(string: "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/walmartproducts/2972a910-7d80-44e6-a595-9cf3ef0cac02/\(page * pageSize)/\(pageSize)") else {
            print("Improper URL")
            return completion([])
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let productsJSON = json?["products"] as? [[String: Any]]
                else {
                    print("Failed to get json: \(String(describing: error))")
                    completion([])
                    return
            }
            
            let products: [WStoreProduct] = productsJSON.flatMap { productJSON in
                guard let id = productJSON["productId"] as? String,
                    let name = productJSON["productName"] as? String,
                    let shortDescription = productJSON["shortDescription"] as? String,
                    let longDescription = productJSON["longDescription"] as? String,
                    let price = productJSON["price"] as? String,
                    let imageURLString = productJSON["productImage"] as? String,
                    let imageURL = URL(string: imageURLString),
                    let reviewRating = productJSON["reviewRating"] as? Float,
                    let reviewCount = productJSON["reviewCount"] as? Int,
                    let inStock = productJSON["inStock"] as? Bool
                    else { return nil }
                    var prodImage = UIImage()
                    WStoreDataManager.getProductImage(at:imageURL) { image in
                        DispatchQueue.main.async {
                        prodImage = image!
                    }
                }
                
                return WStoreProduct(id: id, name: name, shortDescription: shortDescription, longDescription: longDescription, price: price, imageURL: imageURL, reviewRating: reviewRating, reviewCount: reviewCount, inStock: inStock, productImage: prodImage )
            }
            
            completion(products)
        }
        
        dataTask.resume()
    }
    
    static func getProductImage(at url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                let data = data,
                let image = UIImage(data: data)
                else {
                    print("Error while fetching: \(String(describing: error))")
                    completion(nil)
                    return
            }
            
            completion(image)
        }
        
        dataTask.resume()
    }
}
