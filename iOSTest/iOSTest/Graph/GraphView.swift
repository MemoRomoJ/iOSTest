//  GraphView.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 23/09/22.

import Foundation
import UIKit

class GraphView: UIViewController {
    
    let graphTableView = UITableView()
    var data : GraphEntity?

    // MARK: Properties
    var presenter: GraphPresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        presenter?.viewDidLoad()
        
        self.setTableView()
    }

    func setTableView(){
        graphTableView.backgroundColor = UIColor.clear
        view.addSubview(graphTableView)
        graphTableView.translatesAutoresizingMaskIntoConstraints = false
        graphTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        graphTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        graphTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        graphTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
                        
        graphTableView.register(GraphCell.self, forCellReuseIdentifier: "GraphCell")
        
        graphTableView.estimatedRowHeight = 44.0
        graphTableView.rowHeight = 444.0
    }
}

extension GraphView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GraphCell", for: indexPath) as! GraphCell
        cell.backgroundColor = UIColor.clear
        switch indexPath.row{
        case 0:
            var txts = [String]()
            for d in data!.reporte{
                txts.append(d.valor)
            }
            
            var pers = [Double]()
            for d in data!.reporte{
                pers.append(Double(d.cantidad)!)
            }
            
            cell.configureCell(text: "¿Estaba limpia la sucursal?",
                               texts: txts,
                               percentages: pers)
            return cell
        case 1:
            var txts = [String]()
            for d in data!.empresas{
                txts.append(d.nombre)
            }
            var pers = [Double]()
            for d in data!.empresas{
                pers.append(Double(d.porcentaje))
            }
            cell.configureCell(text: "¿Qué empresas cuentan con medidas de seguridad?",
                               texts: txts,
                               percentages: pers)
            return cell
        default:
            cell.textLabel?.text = "defaultCell"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        graphTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GraphView: GraphViewProtocol {
    func pushDataToView(receivedData: GraphEntity) {
        data = receivedData
        
        DispatchQueue.main.async {
            self.graphTableView.dataSource = self
            self.graphTableView.delegate = self
            self.graphTableView.reloadData()
        }
    }
}
