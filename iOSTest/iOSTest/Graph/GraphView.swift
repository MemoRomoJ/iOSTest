//
//  GraphView.swift
//  iOSTest
//
//  Created by Guillermo Romo Jiménez on 23/09/22.
//  
//

import Foundation
import UIKit

class GraphView: UIViewController {

    // MARK: Properties
    var presenter: GraphPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension GraphView: GraphViewProtocol {
    // TODO: implement view output methods
}
