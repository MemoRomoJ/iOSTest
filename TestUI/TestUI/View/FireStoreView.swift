//  FireStoreView.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 24/09/22.

import SwiftUI

struct FireStoreView: View {
    
    @State var showCameraView = false
    
    var img : UIImage
    
    var body: some View {
        Image(uiImage: img)
    }
}
