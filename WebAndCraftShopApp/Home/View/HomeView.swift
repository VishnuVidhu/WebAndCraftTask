//
//  HomeView.swift
//  WebAndCraftShopApp
//
//  Created by Vishnu V on 25/02/23.
//

import SwiftUI

struct HomeView: View {
    @Binding var cartbadge:Int
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
       VStack {
           HStack{
               Image(systemName: "magnifyingglass").foregroundColor(Color.WCS_Gray_727272).padding([.top,.bottom],15).padding(.leading,10)
               TextField("Search", text: $viewModel.searchText)
               Button {
                   
               } label: {
                   Image(systemName: "barcode.viewfinder").foregroundColor(Color.WCS_Gray_727272)
               }.padding(.trailing,10)

           }.background(Color.WCS_White_FAFAFA).border(Color.WCS_Gray_EDEDED, width: 1).padding([.leading,.trailing],18).padding(.top,20).padding(.bottom,10)
           ScrollView{
            LazyVStack
            {
                CategoryListView(categorys: $viewModel.categoryList)
                BannerListView(banners: $viewModel.bannerList)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack{
                        ForEach(viewModel.products,id:\.id) { product in
                            ProductAdaptorView(product: product, cartItemCount: viewModel.getNumberOfitemsInTheCart(item: product), isFavorite: viewModel.isFavoriteItem(item: product)) { product, isAdd in
                                viewModel.addOrRemoveCartItem(item: product, isAdd: isAdd)
                            } addOrRemoveFavoriteItem: { product in
                                viewModel.addOrRemoveFromFavorite(item: product)
                            }
                           
                        }
                        Rectangle().foregroundColor(Color.clear).frame(width: 20, height: 20)
                    }
                }
                Rectangle().foregroundColor(Color.clear).frame(width: 20, height: 20)
            }
           }.padding([.leading],18)
           
       }
       .onChange(of: self.viewModel.cartBadge, perform: { newValue in
           self.cartbadge = newValue
       })
       .onAppear {
//           if !viewModel.isViewDidLoad
//           {
               viewModel.getMasterListApiData()
               viewModel.isViewDidLoad = true
           //}
       }
       
    }
}
struct CategoryListView:View{
    @Binding var categorys:[CategoryDisplayModel]
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack{
            ForEach(categorys, id: \.id){  category in
               CategoryAdaptorView(category: category)
            }
               Rectangle().foregroundColor(Color.clear).frame(width: 20, height: 20)
            }
            
        }
    }
}

struct CategoryAdaptorView:View{
    var category:CategoryDisplayModel
    var body:some View{
        VStack(alignment: .center, spacing: 5){
        ZStack{
            category.bgColode
            AsyncImage(url: URL(string: category.imageURL)) { image in
                image.resizable().frame(width: 60, height: 60).padding(5)
            } placeholder: {
                Image(systemName: "photo").resizable().frame(width: 40, height: 40).padding(5)
            }
        }.frame(width: 70, height: 70).cornerRadius(35)
            Text(category.name).font(.body).foregroundColor(Color.black)
        }
        }
    }

struct BannerListView:View{
    @Binding var banners:[BannersDisplayModel]
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack{
            ForEach(banners, id: \.id){  banner in
                BannerAdaptorView(banner: banner)
            }
               Rectangle().foregroundColor(Color.clear).frame(width: 20, height: 20)
            }
        }
    }
}
struct BannerAdaptorView:View{
    var banner:BannersDisplayModel
    var body:some View{
        ZStack{
            AsyncImage(url: URL(string: banner.imageURL)) { image in
                image.resizable().frame(width: 330, height: 180).padding(5)
            } placeholder: {
                Image(systemName: "photo").resizable().frame(width: 330, height: 180).padding(5)
            }
        }.padding(5)
        
    }
}

struct ProductAdaptorView:View{
    var product:ProductsDisplayModel
    var cartItemCount:Int
    var isFavorite:Bool
    var addOrRemoveCartItem:(_ product:ProductsDisplayModel,_ isAdd:Bool) -> Void
    var addOrRemoveFavoriteItem:(_ product:ProductsDisplayModel) -> Void
    var body:some View{
        ZStack {
            Color.WCS_Gray_EDEDED.cornerRadius(10)
            ZStack {
                Color.white
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            addOrRemoveFavoriteItem(product)
                        } label: {
                            Image.WCS_FavIcon.renderingMode(.template).resizable().foregroundColor(isFavorite ? Color.WCS_Red_E8393A:Color.WCS_Gray_D6D6D6).frame(width: 19, height: 16).padding(10)
                        }
                    }
                    AsyncImage(url: URL(string: product.imageURL)) { image in
                        image.resizable().frame(width: 92, height: 92).padding(5)
                    } placeholder: {
                        Image(systemName: "photo").resizable().frame(width: 92, height: 92).padding(5)
                    }
                    
                    HStack{
                        ZStack{
                            if product.is_express
                            {
                            Color.WCS_Yellow_FFCB01
                            Image.WCS_Delivery.resizable().frame(width: 16, height: 10).padding(1)
                            }
                        }.frame(width: 18, height: 12)
                        Spacer()
                    }
                    if product.offer > 0
                    {
                    HStack{
                        Text(product.offer_price).font(Font.system(size: 12)).foregroundColor(Color.WCS_Gray_727272).overlay {
                            Rectangle().foregroundColor(Color.WCS_Gray_727272).frame( height:0.5)
                    }
                        Spacer()
                    }
                    }
                    HStack{
                        Text(product.actual_price).font(Font.system(size: 15, weight: .bold, design: .default)).foregroundColor(Color.WCS_Black_1D211E)
                        Spacer()
                    }
                    HStack{
                        Text(product.name).font(Font.system(size: 15)).foregroundColor(Color.WCS_Black_1D211E).lineLimit(2).multilineTextAlignment(.leading)
                        Spacer()
                    }.frame(height: 40)
                    if cartItemCount == 0
                    {
                    Button {
                        addOrRemoveCartItem(product,true)
                    } label: {
                        ZStack{
                            Color.WCS_Green_199B3B
                            Text("ADD").font(Font.system(size: 16, weight: .semibold, design: .default)).foregroundColor(Color.white).padding(4)
                        }.cornerRadius(4).frame(width: 112, height: 30)
                    }.padding()
                    }
                    else{
                        HStack{
                            Button {
                                addOrRemoveCartItem(product,false)
                            } label: {
                                ZStack{
                                    Color.WCS_Green_199B3B
                                    Text("-").font(Font.system(size: 16, weight: .semibold, design: .default)).foregroundColor(Color.white)
                                }.cornerRadius(4).frame(width:30,height: 30)
                            }
                            Text("\(cartItemCount)")
                            Button {
                                addOrRemoveCartItem(product,true)
                            } label: {
                                ZStack{
                                    Color.WCS_Green_199B3B
                                    Text("+").font(Font.system(size: 16, weight: .semibold, design: .default)).foregroundColor(Color.white)
                                }.cornerRadius(4).frame(width:30,height: 30)
                            }
                        }.padding()
                    }

                }.padding(5)
            }.cornerRadius(10).padding(0.5).frame(width: 170)
        }.overlay(alignment: .topLeading) {
            if product.offer > 0
            {
            VStack{
                Text("\(product.offer) % OFF").font(Font.system(size: 10)).foregroundColor(Color.white).padding([.leading,.trailing],7).padding(3)
            }.background(Color.WCS_Red_E8393A)
            }
        }
        
    }
}
