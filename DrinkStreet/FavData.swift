//
//  FavData.swift
//  DrinkStreet
//
//  Created by Kirthi Maharaj on 2021/08/18.
//

import Foundation

//
//final class FavManager {
//
//    static func setUpDefaultAccountManager(favManager: FavManager) {
//        defaultFavManager = favManager
//    }
//    static var defaultFavManager: FavManager!
//    
//
//
//    func favoriteProduct(favorite: Bool, bardrink: DrinkDetail, completion: (Bool) -> ()) {
//        bardrink.isFav = favorite
//        FurniAPI.sharedInstance.request("favorites", method: favorite ? "POST" : "DELETE", encoding: .JSON, parameters: [
//            "product": "\(product.id)",
//            "collection": product.collectionPermalink,
//            "cognitoId": self.cognitoID]) { response in
//                let success = response != nil
//                if !success {
//                    product.isFavorited = !favorite
//                }
//
//                completion(success)
//        }
//    }
//
//}
