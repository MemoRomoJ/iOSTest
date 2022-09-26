////  UserViewModel.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 24/09/22.

import Foundation
import UIKit
import Firebase
import SwiftUI

final class UserViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    
    @Published var user = User()

    var userList : [User]?
    var photo = UIImage(systemName: "option")!
    
    init(){
        self.userList = []
        readUsers()
    }
    
    //read all users
    func readUsers(){
        /// Listener to read color and update in realtime
        ref = Database.database().reference(withPath: DbRoutes.users.rawValue)
        ref.observe(DataEventType.value, with: { (snapshot) in

            if snapshot.childrenCount > 0 {

                self.userList!.removeAll()

                for user in snapshot.children.allObjects as! [DataSnapshot] {
                    let userObj = user.value as? [String: AnyObject]
                    guard let value = userObj else { return }
                    do {

                        let model = try FirebaseDecoder().decode(User.self, from: value)
                        print(model)
                        
                        self.userList!.append(model)
                        
                    } catch let error {
                        print(error)
                    }
                }
            }
        })

    }
    
    ///send user to fireStore
    
    // send to realtimeDataBase
    func toRealtimeDB(){
        let firebase = Firebase( baseURL: fireBaseURL,
                    accessToken: Firebase.init().accessToken)
                
        let model = try! FirebaseEncoder().encode(user)
        
        firebase.setValue(path: DbRoutes.users.rawValue + "/\(self.userList!.count)", value: model,
                          asyncCompletion: { (error) in
            debugPrint("Completed")
            if error != nil {
                print("oops, an error")
            } else {
                print("completed")
            }
        })
    }
    
    // send to Storage
    func sendToStorage(){
        if let data = photo.pngData() {
            FirebaseStorageManager().uploadImageData(data: data, serverFileName: "selfie\(self.userList!.count).png") { (isSuccess, url) in
                if isSuccess{
                    self.user.photoURL = url ?? "error 404"
                    self.user.id = self.userList!.count
                    self.toRealtimeDB()
                }
            }
        }
    }
}
