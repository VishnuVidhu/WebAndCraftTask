//
//  Image+ColorExtension.swift
//  WebAndCraftShopApp
//
//  Created by Vishnu V on 26/02/23.
//

import Foundation
import SwiftUI

extension Color{
    static let WCS_Black_1D211E = Color("WCS_Black_1D211E")
    static let WCS_Gray_727272 = Color("WCS_Gray_727272")
    static let WCS_Gray_EDEDED = Color("WCS_Gray_EDEDED")
    static let WCS_Green_199B3B = Color("WCS_Green_199B3B")
    static let WCS_Red_E8393A = Color("WCS_Red_E8393A")
    static let WCS_White_FAFAFA = Color("WCS_White_FAFAFA")
    static let WCS_Yellow_FFCB01 = Color("WCS_Yellow_FFCB01")
    static let WCS_Gray_D6D6D6 = Color("WCS_Gray_D6D6D6")
    static var random: Color {
           return Color(
               red: .random(in: 0...1),
               green: .random(in: 0...1),
               blue: .random(in: 0...1)
           )
       }
}

extension Image{
    static let WCS_FavIcon = Image("WCS_FavIcon")
    static let WCS_Delivery = Image("WCS_Delivery")
  
}
