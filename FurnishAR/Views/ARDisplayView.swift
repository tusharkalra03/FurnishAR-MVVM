//
//  ARView.swift
//  FurnishAR
//
//  Created by Tushar Kalra.
//

import SwiftUI
import RealityKit
import ARKit

struct ARDisplayView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var name: String
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            ARViewContainer(name: name)
                .ignoresSafeArea()
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width:20,height: 20)
                    .foregroundColor(.black)
                    .padding()
                    .background(.white.opacity(0.6))
                    .cornerRadius(10)
                    .padding()
            }
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    var name: String

    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.environmentTexturing = .automatic
        config.planeDetection = [.horizontal,.vertical]
        arView.session.run(config)
        arView.debugOptions = [.showWorldOrigin,.showFeaturePoints]
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let modelEntity = try! ModelEntity.loadModel(named: name)
        let anchorEntity = AnchorEntity()
        
        anchorEntity.addChild(modelEntity)
        modelEntity.position = [0,-0.6,0]
        uiView.scene.addAnchor(anchorEntity)
    }
    
    
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARDisplayView(name: "hallingdal chair")
    }
}
