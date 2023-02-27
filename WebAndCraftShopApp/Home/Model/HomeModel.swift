//
//  File.swift
//  WebAndCraftShopApp
//
//  Created by Vishnu V on 26/02/23.
//

import Foundation
import SwiftUI
struct HomeModelManger {
    
    func getHomeMasterDatas(compleation:@escaping(_ category:[CategoryDisplayModel],_ banners:[BannersDisplayModel],_ product:[ProductsDisplayModel],_ sectionType:[HomeMasterDataType]) -> Void)
    {
        DispatchQueue(label: "api-Queue").async {
            ApiManager.shared.getShopMasterData { errorMessage, resposeDataModel in
                let result = getToupleDataFromMasterData(masterData: resposeDataModel)
                compleation(result.category,result.banners,result.product, result.sectionType)
            }
        }
       
    }
}
extension HomeModelManger{
    private func getToupleDataFromMasterData(masterData:ShopMasterDataModel?) -> (category:[CategoryDisplayModel],banners:[BannersDisplayModel],product:[ProductsDisplayModel],sectionType:[HomeMasterDataType])
    {
        var category:[CategoryDisplayModel] = []
        var banners:[BannersDisplayModel] = []
        var product:[ProductsDisplayModel] = []
        var sectionType:[HomeMasterDataType] = []
        if let masterData = masterData {
            // making section as dinamicaly.
            sectionType = (masterData.homeData ?? []).compactMap({HomeMasterDataType.getType(string:$0.type ?? "")})
            for data in masterData.homeData ?? []
            {
               if let type = HomeMasterDataType.getType(string: data.type ?? "")
               {
                   switch type {
                   case .category:
                       category +=  (data.values ?? []).map({CategoryDisplayModel(item: $0)})
                   case .banners:
                       banners +=  (data.values ?? []).map({BannersDisplayModel(item: $0)})
                   case .products:
                       product +=  (data.values ?? []).map({ProductsDisplayModel(item: $0)})
                   }
                   
               }
        }
        }
        return (category:category,banners:banners,product:product,sectionType:sectionType)
    }
}


struct CategoryDisplayModel{
    let name:String
    let imageURL:String
    let id:Int
    let bgColode:Color
    init(item:ValuesModel)
    {
        self.name = item.name ?? ""
        self.imageURL = item.image_url ?? ""
        self.id = item.id ?? 0
        self.bgColode = Color.random.opacity(0.5)
        
    }
}
struct BannersDisplayModel{
    let name:String
    let imageURL:String
    let id:Int
    init(item:ValuesModel)
    {
        self.name = item.name ?? ""
        self.imageURL = item.banner_url ?? ""
        self.id = item.id ?? 0
        
    }
}
struct ProductsDisplayModel{
    let name:String
    let imageURL:String
    let id:Int
    let actual_price : String
    let offer_price : String
    let offer:Int
    let is_express:Bool
    
    init(item:ValuesModel)
    {
        self.name = item.name ?? ""
        self.imageURL = item.image ?? ""
        self.id = item.id ?? 0
        self.actual_price = item.actual_price ?? ""
        self.offer_price = item.offer_price ?? ""
        self.offer = item.offer ?? 0
        self.is_express = item.is_express ?? false
        
    }
}

enum HomeMasterDataType:String,CaseIterable{
    case category = "category"
    case banners = "banners"
    case products = "products"
    
    static func getType(string:String) -> HomeMasterDataType?
    {
        return HomeMasterDataType.allCases.first(where: {$0.rawValue.lowercased() == string.lowercased()})
    }
    
}
