//  MainView.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 24/09/22.

import SwiftUI
import Combine
import AVFoundation

struct MainView: View {
    
    @ObservedObject private var viewModel = UserViewModel()
        
    @State var showCamera = false
    @State var showCameraView = false
    @State var showCameraAlert = false
    
    var body: some View {
        NavigationView(){
            VStack{
                List {
                    /// 1 Texfield validado solo letras
                    TextField("Nombre", text: $viewModel.user.name)
                        .padding(.horizontal, 20.0)
                        /*.onReceive(Just(viewModel.user.name)) { newValue in
                            let filtered = newValue.filter { "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz".contains($0) }
                            if filtered != newValue {
                                self.viewModel.user.name = filtered
                            }
                        }*/
                    
                    /// 2 selfie button
                    HStack{
                        Button(action: {
                            cameraAccess()
                        }) {
                            Text("Tomar foto selfie")
                        }
                        .sheet(isPresented: $showCamera) {
                            ImagePicker(sourceType: .camera, selectedImage: self.$viewModel.photo)
                        }
                        .buttonStyle(GrowingButton())
                        
                        Spacer()
                        
                        Button(action: {
                            showCameraAlert = true
                        }) {
                            Image(systemName: "option")
                        }
                        .sheet(isPresented: $showCameraView) {
                            //Image(uiImage: viewModel.user.photo!)
                            Image(uiImage: viewModel.photo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .buttonStyle(GrowingButton())
                    }
                    
                    /// 3/4 API & Graphs
                    NavigationLink(longGraphText,
                                   destination:
                                    GraphView()
                    )
                    
                    /// 6 Lista de usuarios realTime
                    NavigationLink("Lista de users en realtimeDB",
                                   destination:
                                    UsersListView(userList: self.$viewModel.userList)
                    )
                    
                    /// 7/8 Editar colores tiempo real de otra app
                    NavigationLink("Editar Colores realTime Firebase backgroundColor",
                                   destination:
                                    BGColorView()
                    )
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.sendToStorage()
                }) {
                    Text("Enviar Nombre & Foto a Firebase")
                }
                .buttonStyle(GrowingButton())
            }
            .alert("¿Visualizar o Retomar Foto?", isPresented: $showCameraAlert){
                Button("Visualizar") {
                    showCameraAlert = false
                    showCameraView = true
                }
                Button("Retomar Foto") {
                    showCameraAlert = false
                    cameraAccess()
                }
                Button("Cancelar") {
                    showCameraAlert = false
                }
            }
        }
    }
    
    func cameraAccess(){
        //tomar foto y guardar en global as UIImage.data..
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            self.setupCaptureSession()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupCaptureSession()
                }
            }
            
        case .denied: // The user has previously denied access.
            return
            
        case .restricted: // The user can't grant access due to restrictions.
            return
        }
    }
    
    func setupCaptureSession(){
        showCamera = true
    }
    
}
