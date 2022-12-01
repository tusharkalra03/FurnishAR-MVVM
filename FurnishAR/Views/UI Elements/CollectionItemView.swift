//
//  CollectionItemView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI

struct CollectionItemView: View {
    //MARK: - Variable
    var collection: ItemCategory
    
    //MARK: - View
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                Image(collection.rawValue.lowercased())
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding()
                    .cornerRadius(8)
                
                Text(collection.rawValue)
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.semibold)
                
            }
            .padding(.vertical)
        }
        .background(.white)
        .cornerRadius(8)
    }
}

struct CollectionItemView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionItemView(collection: ItemCategory.chair)
    }
}
