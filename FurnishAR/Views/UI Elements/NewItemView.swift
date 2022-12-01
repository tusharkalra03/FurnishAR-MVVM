//
//  NewItemView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI

struct NewItemView: View {
    //MARK: - Variables
    let item: Item
    
    //MARK: - View
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack{
                VStack {
                    Color.clear
                }
                .frame(height: 60)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Spacer()
                    }
                    
                    Spacer().frame(height: 180)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        RoundedRectangle(cornerRadius: 12.0)
                            .fill(LinearGradient(
                                gradient: .init(colors: [AppColors.color1,AppColors.color2]),
                                startPoint: .init(x: 0.3, y: 0.5),
                                endPoint: .init(x: 0.7, y: 0.5)
                            ))
                        
                            .frame(width: 75, height: 40)
                            .padding(.vertical)
                            .overlay {
                                Text("NEW")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        
                        Text(item.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        HStack(spacing: 4){
                            ForEach(0..<Int(item.rating), content: { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            })
                        }
                        
                        Spacer()
                            .frame(height: 15)
                        
                        Text(item.company)
                            .font(.title3)
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                        
                        Text("$\(item.price)")
                            .font(.title3)
                            .foregroundColor(.gray)
                        
                    }
                    .padding()
                }
                .background(.white.opacity(1))
                .cornerRadius(16)
            }
            
            Image(item.name.lowercased())
                .renderingMode(.original)
                .resizable()
                .frame(height: 250)
                .aspectRatio(1, contentMode: .fit)
            
        }
        .frame(width: 230)
        .cornerRadius(12)
    }
}

//MARK: - Preview
struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(item: AppModel().newItems[0])
            .preferredColorScheme(.light)
    }
}
