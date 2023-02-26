//
//  MasterDataModel.swift
//  WebAndCraftShopApp
//
//  Created by Vishnu V on 26/02/23.
//

import Foundation

struct ShopMasterDataModel : Codable {
    let status : Bool?
    let homeData : [HomeDataModel]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case homeData = "homeData"
    }

    init(from decoder: Decoder) throws {
        let decodedvalues = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? decodedvalues?.decodeIfPresent(Bool.self, forKey: .status)
        homeData = try? decodedvalues?.decodeIfPresent([HomeDataModel].self, forKey: .homeData)
    }

}

struct HomeDataModel : Codable {
    let type : String?
    let values : [ValuesModel]?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case values = "values"
    }

    init(from decoder: Decoder) throws {
        let decodedvalues = try? decoder.container(keyedBy: CodingKeys.self)
        type = try? decodedvalues?.decodeIfPresent(String.self, forKey: .type)
        values = try? decodedvalues?.decodeIfPresent([ValuesModel].self, forKey: .values)
    }

}
struct ValuesModel : Codable {
    let id : Int?
    let name : String?
    let image_url : String?
    let banner_url:String?
    let actual_price : String?
    let offer_price : String?
    let offer:Int?
    let is_express:Bool?
    let image:String?
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case image_url = "image_url"
        case banner_url = "banner_url"
        case actual_price = "actual_price"
        case offer_price = "offer_price"
        case offer = "offer"
        case is_express = "is_express"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let decodedvalues = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? decodedvalues?.decodeIfPresent(Int.self, forKey: .id)
        name = try? decodedvalues?.decodeIfPresent(String.self, forKey: .name)
        image_url = try? decodedvalues?.decodeIfPresent(String.self, forKey: .image_url)
        banner_url = try? decodedvalues?.decodeIfPresent(String.self, forKey: .banner_url)
        actual_price = try? decodedvalues?.decodeIfPresent(String.self, forKey: .actual_price)
        offer_price = try? decodedvalues?.decodeIfPresent(String.self, forKey: .offer_price)
        offer = try? decodedvalues?.decodeIfPresent(Int.self, forKey: .offer)
        is_express = try? decodedvalues?.decodeIfPresent(Bool.self, forKey: .is_express)
        image = try? decodedvalues?.decodeIfPresent(String.self, forKey: .image)
    }

}
