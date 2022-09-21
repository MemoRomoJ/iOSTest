//  ViewController.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 21/09/22.

import UIKit
import Firebase

class ViewController: UIViewController {

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBGColorListener()
    }

    func setBGColorListener(){
        /// Listener to read color and update in realtime
        ref = Database.database().reference(withPath: "backgroundViewsColor")
        ref.observe(DataEventType.value, with: { (snapshot) in
            do {
                let model = try FirebaseDecoder().decode(BackGColor.self, from: snapshot.value)
                
                self.view.backgroundColor = UIColor(red: model.red,
                                                         green: model.green,
                                                         blue: model.blue,
                                                         alpha: model.alpha)
            } catch let error {
                print(error)
            }
        })
    }

}

