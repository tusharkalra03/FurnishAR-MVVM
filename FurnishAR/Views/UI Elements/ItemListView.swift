//
//  ItemListView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI

struct ItemListView: View {
    //MARK: - Variable
    var item: Item!
    
    //MARK: - View
    var body: some View {
        ZStack{
            HStack(alignment: .top){
                Image(item.name.lowercased())
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                    .background(AppColors.bg)
                    .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 8){
                    Text(item.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        
                    Text(item.company)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    
                    Spacer()
                        .frame(height: 25)
                    
                    
                    Text("$\(item.price)")
                        .font(.title2)
                }
                .padding(.horizontal)
                
                Spacer()

            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(16)

    }
}

