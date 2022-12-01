//
//  ContentView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    //MARK: - Variables
    @StateObject var appModel = AppModel()
    
    //MARK: - View
    var body: some View {
        MainView(appModel: appModel)
        
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
