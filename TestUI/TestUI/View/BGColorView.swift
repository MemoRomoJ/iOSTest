//  BGColorView.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 25/09/22.

import SwiftUI
import Firebase


struct BGColorView: View {
    
    @State var ref: DatabaseReference!
    
    @State var bgColor : BackGColor?
    
    @State var red = 0.0
    @State var green = 0.0
    @State var blue = 0.0
    
    var body: some View{
        VStack{
            
            Circle()
                .strokeBorder(.black, lineWidth: 20)
                .background(Circle().fill(
                    Color(uiColor: UIColor(red: red, green: green, blue: blue, alpha: 1.0))
                ))
                .frame(width: 150, height: 150)
            
            
            HStack{
                Slider(value: $red,in: 0.001...0.999)
                    .accentColor(.red)
                
                Spacer()
                
                Text("R : \(red)")
            }
            
            
            HStack{
                Slider(value: $green,in: 0.001...0.999)
                    .accentColor(.green)
                
                Spacer()
                
                Text("R : \(green)")
            }
            
            
            HStack{
                Slider(value: $blue,in: 0.001...0.999)
                    .accentColor(.blue)
                
                Spacer()
                
                Text("R : \(blue)")
            }
            
            Spacer()
            
            Button(action: {
                let firebase = Firebase( baseURL: fireBaseURL,
                            accessToken: Firebase.init().accessToken)
                
                bgColor?.red = red
                bgColor?.green = green
                bgColor?.blue = blue
                
                let model = try! FirebaseEncoder().encode(bgColor)
                
                firebase.setValue(path: "backgroundViewsColor", value: model,
                                  asyncCompletion: { (error) in
                    debugPrint("Completed")
                    if error != nil {
                        print("oops, an error")
                    } else {
                        print("completed")
                    }
                })
                
            }) {
                Text("Enviar cambios a Firebase realtime")
            }
            .buttonStyle(GrowingButton())
        }
        .padding()
        .onAppear(){
            /// Listener to read color and update in realtime
            ref = Database.database().reference(withPath: "backgroundViewsColor")
            ref.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                do {
                    let model = try FirebaseDecoder().decode(BackGColor.self, from: snapshot.value)
                    
                    self.bgColor = model
                    self.red = model.red
                    self.green = model.green
                    self.blue = model.blue
                    
                } catch let error {
                    print(error)
                }
            })

        }
    }
}
