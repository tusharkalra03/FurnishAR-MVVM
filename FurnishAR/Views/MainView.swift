//
//  MainView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI

struct MainView: View {
    
    //MARK: - Variables
    
    @State private var showDetailView = false
    @State private var selectedItem: Item?
    @State private var showCartView = false
    @State private var showCollectionView = false
    @State private var selectedCollection: ItemCategory?
    
    @ObservedObject var appModel: AppModel
    
    //MARK: - View
    var body: some View {
        VStack {
            if !showDetailView {
                ZStack{
                    VStack{
                        //MARK: - Top Buttons
                        HStack{
                            Button {
                                print("DEBUG: Account button pressed")
                            } label: {
                                Image(systemName: "person")
                                    .resizable()
                                    .frame(width:20,height: 20)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(.white.opacity(0.6))
                                    .cornerRadius(10)
                            }
                            
                            Spacer()
                            
                            Button {
                                cartViewToggle()
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
                        .padding(.top, 34)
                        .padding(.horizontal)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            //MARK: - New Arrivals
                            VStack{
                                HStack {
                                    Text("New Arrivals")
                                        .foregroundColor(.black)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                }
                                
                                ScrollView(.horizontal){
                                    HStack(spacing: 25){
                                        ForEach(appModel.newItems){ item in
                                            
                                            NewItemView(item: item)
                                                .gesture(TapGesture().onEnded({ _ in
                                                    selectedItem = item
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                        withAnimation(.easeInOut){
                                                            showDetailView = true
                                                            
                                                        }
                                                    }
                                                    
                                                }))
                                            
                                        }
                                    }
                                }
                            }
                            //MARK: - Collections
                            VStack{
                                HStack(alignment: .center) {
                                    Text("Collections")
                                        .foregroundColor(.black)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Spacer()
                                    
                                }
                     
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20),count: 2),spacing: 20){
                                    ForEach(ItemCategory.allCases, id: \.rawValue){ collection in
                                        CollectionItemView(collection: collection)
                                            .onTapGesture {
                                                selectedCollection = collection
                                                collectionViewToggle()
                                            }
                                    }
                                    
                                }
                               
                            }
                            .padding(.top)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .padding(.vertical)
                }
                .background(AppColors.bg)
                .ignoresSafeArea()
            }
            //MARK: - Show Detail View
            else {
                DetailView(item: selectedItem, appModel: appModel)
                    .transition(.move(edge: .trailing))
            }
        }
        //MARK: - Present Cart View
        .fullScreenCover(isPresented: $showCartView, onDismiss: nil) {
            CartView(appModel: appModel)
        }
        //MARK: - Present Collection View
        .fullScreenCover(item: $selectedCollection) { item in
            CollectionView(collection: item, appModel: appModel)
        }
        
    }
    
    //MARK: - Toggle Cart View
    private func cartViewToggle(){
        showCartView = true
    }
    
    //MARK: - Toggle Collection View
    private func collectionViewToggle(){
        withAnimation(.easeInOut){
            showCollectionView = true
        }
    }
}

//MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(appModel: AppModel())
            .preferredColorScheme(.light)
    }
}








