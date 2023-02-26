//
//  ContentView.swift
//  WebAndCraftShopApp
//
//  Created by Vishnu V on 25/02/23.
//

import SwiftUI

struct DashboardTabView: View {
    @StateObject var viewModel = DashboardViewModel()
    var body: some View {
        TabView{
            HomeView(cartbadge: $viewModel.cartbadge).tabItem {
               Label("Home", systemImage: "house")
            }.tag(DashboardTabType.home.rawValue)
            Text("Category").tabItem {
               Label("Category", systemImage: "circle.grid.3x3.fill")
            }.tag(DashboardTabType.home.rawValue)
            Text("Offers").tabItem {
               Label("Offers", systemImage: "tag.circle")
            }.tag(DashboardTabType.home.rawValue)
            Text("Cart").tabItem {
               Label("Cart", systemImage: "cart")
            }.tag(DashboardTabType.home.rawValue).badge(viewModel.cartbadge)
            Text("Accoun").tabItem {
               Label("Account", systemImage: "person")
            }.tag(DashboardTabType.home.rawValue)
        }
    }
}

struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}
