//
//  ApiManager.swift
//  WebAndCraftShopApp
//
//  Created by Vishnu V on 26/02/23.
//

import Foundation
import SystemConfiguration
final class ApiManager:Operation{
    static public var shared = ApiManager()
    private override init() {
        
    }
    var isNetWorkAvailable:Bool{
        get{
            self.isConnectedTotheNetWork()
        }
    }
    func getShopMasterData(compleation:@escaping(_ errorMessage:String?,_ resposeDataModel:ShopMasterDataModel?)-> Void)
    {
        var request = URLRequest(url: URL(string: ApiURL.GetShopMasterDataModelURL)!)
        request.httpMethod = "GET"
       if isNetWorkAvailable
        {
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data else {
                compleation(error?.localizedDescription ?? "",nil)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(ShopMasterDataModel.self, from: data)
                compleation(nil,responseModel)
            } catch {
                print("JSON Serialization error")
                compleation("JSON Serialization error",nil)
            }
        }).resume()
       }
        else{
            compleation("No network available",nil)
        }
    }
}
extension ApiManager{
    private func isConnectedTotheNetWork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags : SCNetworkReachabilityFlags = []
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        if (isReachable && !needsConnection)
        {
            return true
        }
        else
        {
            return false
        }
    }
}
