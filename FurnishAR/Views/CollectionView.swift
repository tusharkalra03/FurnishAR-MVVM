//
//  CollectionView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI

struct CollectionView: View {
    
    //MARK: - Variables
    
    @State private var goBack = false
    @State var selectedItem: Item?
    @State private var showDetailView = false
    @State private var showCartView = false
    
    var collection: ItemCategory!
    @ObservedObject var appModel: AppModel
    
    //MARK: - View
    var body: some View {
        
        VStack {
             if !goBack {
                VStack {
                    //MARK: - Top Buttons
                    HStack{
                        Button {
                            backPressed()
                        } label: {
                            Image(systemName: "arrow.left" )
                                .resizable()
                                .frame(width:20,height: 20)
                                .foregroundColor(.black)
                                .padding()
                                .background(.white.opacity(0.6))
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Text(collection.rawValue)
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            withAnimation(.easeInOut){
                                showCartView.toggle()
                            }
                        } label: {
                            Image(systemName: "bag")
                                .resizable()
                                .frame(width:20,height: 20)
                                .foregroundColor(.black)
                                .padding()
                                .background(.white.opacity(0.6))
                                .cornerRadius(10)
                        }
                        
                    }
                    .padding(.horizontal)
                    //MARK: - List of items
                    ScrollView(.vertical){
                        VStack(spacing: 20) {
                            ForEach(appModel.filterItems(by: collection)){ item in
                                ItemListView(item: item)
                            }
                        }
                        .padding()
                    }
                }
                .background(AppColors.bg)
                 //MARK: - Show cart view
                .fullScreenCover(isPresented: $showCartView) {
                    CartView(appModel: appModel)
            }
            }
            //MARK:  Go back to Main view
            else {
                MainView(appModel: appModel)
                    .transition(.slide)
            }
        }
    }
    
    //MARK: - Back button pressed
    func backPressed(){
        withAnimation {
            goBack = true
        }
    }
}

//MARK: - Preview
struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(collection: ItemCategory.storage, appModel: AppModel())
    }
}
