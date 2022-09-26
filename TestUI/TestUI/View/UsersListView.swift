//  UsersListView.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 24/09/22.

import SwiftUI

struct UsersListView: View {
    
    @Binding var userList : [User]?
        
    var body: some View {
        List(userList!){ val in
            VStack{
                Text("\(val.name)")
                    .padding()
                
                AsyncImage(
                    url: (URL(string: val.photoURL) ??
                          URL(string: "https://firebasestorage.googleapis.com:443/v0/b/iostest-1d333.appspot.com/o/uploads%2Fselfie.png?alt=media&token=878df723-d426-4758-b605-63df92d8c2df"))!,
                    placeholder: {
                        ProgressView()
                    },
                    image: { Image(uiImage: $0).resizable() }
                )
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4.0)
            }
        }
    }
}
