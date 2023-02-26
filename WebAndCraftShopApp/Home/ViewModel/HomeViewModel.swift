//
//  HomeViewModel.swift
//  WebAndCraftShopApp
//
//  Created by Vishnu V on 26/02/23.
//

import Foundation
import SwiftUI

final class HomeViewModel:ObservableObject{
    @Published var categoryList:[CategoryDisplayModel] = []
    @Published var bannerList:[BannersDisplayModel] = []
    @Published var products:[ProductsDisplayModel] = []
    @Published var selectedCartItem:[ProductsDisplayModel] = []{
        didSet
        {
            cartBadge = self.selectedCartItem.count
        }
    }
    @Published var favoriteItem:[ProductsDisplayModel] = []
    @Published var searchText = ""
    @Published var cartBadge = 0
    var isViewDidLoad:Bool = false
    func getMasterListApiData()
    {
        HomeModelManger().getHomeMasterDatas { category, banners, product in
            DispatchQueue.main.async { [weak self] in
                self?.categoryList = category
                self?.bannerList = banners
                self?.products = product
            }
        }
    }
    func addOrRemoveFromFavorite(item:ProductsDisplayModel)
    {
        if let index = self.favoriteItem.firstIndex(where: {$0.id == item.id})
        {
            self.favoriteItem.remove(at: index)
        }
        else{
            self.favoriteItem.append(item)
        }
    }
    func addOrRemoveCartItem(item:ProductsDisplayModel,isAdd:Bool)
    {
        if isAdd{
            self.selectedCartItem.append(item)
        }else if let index = self.selectedCartItem.firstIndex(where: {$0.id == item.id}){
            self.selectedCartItem.remove(at: index)
            
        }
    }
    func getNumberOfitemsInTheCart(item:ProductsDisplayModel) -> Int
    {
        self.selectedCartItem.filter({$0.id == item.id}).count
    }
    func isFavoriteItem(item:ProductsDisplayModel) -> Bool
    {
        self.favoriteItem.filter({$0.id == item.id}).count > 0
    }
}
