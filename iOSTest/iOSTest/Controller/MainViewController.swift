//  ViewController.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 21/09/22.

import UIKit
import Firebase

class MainViewController: UIViewController {

    let testTableView = UITableView()

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
        testTableView.delegate = self
        
        testTableView.register(TextFieldCell.self, forCellReuseIdentifier: "Cell1")
        testTableView.register(ButtonCell.self, forCellReuseIdentifier: "Cell2")
        testTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell3")
        testTableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        
        testTableView.estimatedRowHeight = 44.0
        testTableView.rowHeight = UITableView.automaticDimension
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

    @objc func sendToFireStore(sender: UIButton!) {
      print("sendToFireStore")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! TextFieldCell
            cell.configureCell()
            cell.sampleTextField.delegate = self
            cell.backgroundColor = UIColor.clear
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! ButtonCell
            cell.configureCell()
            cell.backgroundColor = UIColor.clear
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "Una gráfica o representación gráfica es un tipo de representación de datos, generalmente numéricos, mediante recursos visuales (líneas, vectores, superficies o símbolos), para que se manifieste visualmente la relación matemática o correlación estadística que guardan entre sí. También es el nombre de un conjunto de puntos que se plasman en coordenadas cartesianas y sirven para analizar el comportamiento de un proceso o un conjunto de elementos o signos que permiten la interpretación de un fenómeno. La representación gráfica permite establecer valores que no se han obtenido experimentalmente sino mediante la interpolación (lectura entre puntos) y la extrapolación (valores fuera del intervalo experimental)."
            cell.backgroundColor = UIColor.clear
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            cell.textLabel?.text = "defaultCell"
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        testTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1{
            //Alert de visualizar o retomar foto
            let alert = UIAlertController(title: "Alerta", message: "Visualizar o Retomar Foto", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Vizualizar", comment: "Default action"), style: .default, handler: { _ in
                
                let newViewController = SelfieDetailViewController()
                self.present(newViewController, animated: true , completion: nil)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Retomar", comment: "Default action"), style: .default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
        if indexPath.row == 2{
            let newViewController = GraphViewController()
            //self.navigationController?.pushViewController(newViewController, animated: true)
            self.present(newViewController, animated: true , completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
        let button = UIButton()
        button.frame = CGRect(x: 8, y: 0, width: footerView.frame.width - 16, height: 60)
        // midx y del superView
        button.setTitle("Enviar Selfie a FireStore", for: .normal)
        button.setTitleColor( UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(sendToFireStore), for: .touchUpInside)

        button.backgroundColor = UIColor.black
        footerView.addSubview(button)
        return footerView
    }
}
