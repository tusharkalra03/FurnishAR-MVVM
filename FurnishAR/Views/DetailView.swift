//
//  DetailView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI

struct DetailView: View {
    
    //MARK: - Variables
    @State var goBack = false
    
    @State var showCartView = false
    @State var addedToCart = false
    @State var showARView = false
    @State var showNoPermissionAlert = false
    @State var showNoCameraAlert = false
    
    var item: Item!
    
    @ObservedObject var appModel: AppModel
    
    //MARK: - View
    var body: some View {
        
        VStack {
            if !goBack {
                VStack {
                    VStack(spacing: 8){
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
                            
                            Button {
                                showCartView = true
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
                        
                        //MARK: - Scroll View
                        ScrollView(.vertical){
                            Image(item.name.lowercased())
                                .renderingMode(.original)
                                .resizable()
                                .frame(height: 300)
                                .aspectRatio(1, contentMode: .fit)
                                .padding()
                            
                        
                        
                        VStack(alignment: .leading, spacing: 10){
                            HStack {
                                Text(item.name)
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .fontWeight(.heavy)
                                
                                Spacer()
                                
                                Button {
                                    checkCameraConfig()
                                } label: {
                                    Text("View in AR")
                                        .foregroundColor(.black)
                                        .fontWeight(.medium)
                                }
                                .buttonStyle(.bordered)
                                .cornerRadius(14)
                            }
                            
                            Spacer().frame(height: 5)
                            
                            Text("Description")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.semibold)
                            
                            Text(item.description)
                                .foregroundColor(.gray)
                            
                            Spacer().frame(height: 5)
                               
                                HStack{
                                    Text("Rating")
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    ForEach(0..<Int(item.rating)){_ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                                            
                            
                            Spacer().frame(height: 15)
                            
                            //MARK: - Add to cart
                            CartButtonView(showCartView: $showCartView, addedToCart: addedToCart, item: item, appModel: appModel)
                            
                            Spacer().frame(height: 100)
                            
                        }
                        .padding()
                        .background(.white.opacity(0.8))
                        
                        Spacer()
                        }
                    }
                }
                .background(AppColors.bg)
            }
            //MARK: - Go Back to Main View
            else {
                MainView(appModel: appModel)
                    .transition(.slide)
            }
        }
        //MARK: - Present Cart View
        .fullScreenCover(isPresented: $showCartView) {
            CartView(appModel: appModel)
        }
        //MARK: - Present AR View
        .fullScreenCover(isPresented: $showARView) {
            ARDisplayView(name: item.name.lowercased())
        }
        //MARK: - Show alerts
        .alert("No camera found", isPresented: $showNoCameraAlert) {
            Button { }
            label: {
                Text("OK")
            }
        }
        .alert("Camera access denied", isPresented: $showNoPermissionAlert) {
            Button { }
            label: {
                Text("OK")
            }
        }
        
        
    }
    
    //MARK: - Back button pressed
    func backPressed(){
        withAnimation {
            goBack = true
        }
    }
    
    //MARK: - Check camera
    func checkCameraConfig(){
        if CameraService.instance.isCameraAvailable() {
            if CameraService.instance.isPermissionGranted {
                showARView = true
            }
            else{
                showNoPermissionAlert = true
            }
        }
        else{
            showNoCameraAlert = true
        }
    }
}

//MARK: - Cart Button View
struct CartButtonView: View {
    
    @Binding var showCartView: Bool
    @State var addedToCart: Bool
    
    var item: Item!
    
    @ObservedObject var appModel: AppModel
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 12.0)
            .fill(LinearGradient(
                gradient: .init(colors: addedToCart ? [AppColors.color2,AppColors.color1]:[AppColors.color1,AppColors.color2]),
                startPoint: .init(x: 0.3, y: 0.5),
                endPoint: .init(x: 0.7, y: 0.5)
            ))
            .frame(height: 70)
            .overlay {
                HStack(spacing: 20){
                    Image(systemName: addedToCart ? "checkmark":"bag")
                        .font(.headline)
                        .padding()
                        .background(AppColors.color3)
                        .cornerRadius(16)
                        .padding(.vertical)
                    
                    Text(addedToCart ? "Go to Cart": "Add to cart")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 1, height: 40)
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text("$\(item!.price)")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                .foregroundColor(.white)
                .onTapGesture {
                    if !addedToCart {
                        appModel.totalAmount += item!.price
                        appModel.cart.append(item!)
                        withAnimation(.easeInOut){
                            self.addedToCart = true
                        }
                    }
                    else{
                        showCartView.toggle()
                        addedToCart.toggle()
                    }
                }
            }
    }
}

//MARK: - Preview
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: AppModel().newItems[0], appModel: AppModel())
    }
}
