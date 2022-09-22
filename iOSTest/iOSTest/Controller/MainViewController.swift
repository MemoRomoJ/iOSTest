//  ViewController.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 21/09/22.

import UIKit
import Firebase

class MainViewController: UIViewController {

    /// 1) table
    let testTableView = UITableView() // view

    /// 4) Realtime backgroundColor
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
        setBGColorListener()
    }
    
    func setTableView(){
        self.testTableView.backgroundColor = UIColor.clear
        view.addSubview(testTableView)
        testTableView.translatesAutoresizingMaskIntoConstraints = false
        testTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        testTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        testTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        testTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        testTableView.dataSource = self
    }

    func setBGColorListener(){
        /// Listener to read color and update in realtime
        ref = Database.database().reference(withPath: "backgroundViewsColor")
        ref.observe(DataEventType.value, with: { (snapshot) in
            do {
                let model = try FirebaseDecoder().decode(BackGColor.self, from: snapshot.value)
                print(model)
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

extension MainViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
          cell.textLabel?.text = "\(indexPath.row)"
          return cell
    }
    
}
