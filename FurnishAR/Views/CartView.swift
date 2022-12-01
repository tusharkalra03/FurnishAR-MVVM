//
//  CartView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI

struct CartView: View {
    
    //MARK: - Variables
    @State var goBack = false
    @State var emptyCart = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var appModel: AppModel
    
    //MARK: - View
    var body: some View {
        
        VStack {
            ZStack {
                VStack(spacing: 20){
                    //MARK: - Top Buttons
                    HStack{
                        Button {
                            presentationMode.wrappedValue.dismiss()
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
                        
                        Text("Cart")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        
                        Button {
                            withAnimation(.easeInOut){
                                emptyCart.toggle()
                            }
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width:20,height: 20)
                                .foregroundColor(.black)
                                .padding()
                                .background(.white.opacity(0.6))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 8)
                    .padding(.horizontal)
                    
                    //MARK: - If cart empty
                    if appModel.cart.isEmpty {
                        VStack {
                            Image("cart1")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 400, height: 500)
                        }
                    }
                    else {
                        //MARK: - List of cart items
                        ScrollView(.vertical){
                            VStack(spacing: 20) {
                                ForEach(appModel.cart){ item in
                                    ItemListView(item: item)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .background(AppColors.bg)
            
            Spacer()
            //MARK: - Cart Description
            if !appModel.cart.isEmpty {
                VStack{
                    VStack(spacing: 24) {
                        HStack {
                            Text("Total (\(appModel.cart.count) items):")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            
                            Text("$\(appModel.totalAmount)")
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical)
                        
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(LinearGradient(
                                gradient: .init(colors: [AppColors.color1,AppColors.color2]),
                                startPoint: .init(x: 0.3, y: 0.5),
                                endPoint: .init(x: 0.7, y: 0.5)
                            ))
                            .frame(height: 70)
                            .overlay {
                                HStack(spacing: 30){
                                    
                                    Text("Proceed to checkout")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding(.leading, 32)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                        .font(.headline)
                                        .padding()
                                        .background(AppColors.color3)
                                        .cornerRadius(16)
                                        .padding(.trailing)
                                    
                                }
                                .foregroundColor(.white)
                            }
                    }
                    .padding()
                }
                .background(.white.opacity(0.8))
            }
            
        }
        .background(AppColors.bg)
        //MARK: - Empty Cart Alert
        .alert(appModel.cart.isEmpty ? "The cart is already empty":"Empty Cart?", isPresented: $emptyCart) {
            if !appModel.cart.isEmpty {
                HStack{
                    Button {
                        withAnimation(.easeInOut){
                            appModel.cart.removeAll()
                        }
                    } label: {
                        Text("Yes")
                    }
                    Button {
                        
                    } label: {
                        Text("No")
                    }
                    
                }
            }
            else {
                Button{}
                label: {
                    Text("OK")
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(appModel: AppModel())
    }
}
