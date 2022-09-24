//
//  GraphProtocols.swift
//  iOSTest
//
//  Created by Guillermo Romo Jiménez on 23/09/22.
//  
//

import Foundation
import UIKit

protocol GraphViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: GraphPresenterProtocol? { get set }
}

protocol GraphWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createGraphModule() -> UIViewController
}

protocol GraphPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: GraphViewProtocol? { get set }
    var interactor: GraphInteractorInputProtocol? { get set }
    var wireFrame: GraphWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol GraphInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol GraphInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: GraphInteractorOutputProtocol? { get set }
    var localDatamanager: GraphLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: GraphRemoteDataManagerInputProtocol? { get set }
}

protocol GraphDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol GraphRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: GraphRemoteDataManagerOutputProtocol? { get set }
}

protocol GraphRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol GraphLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
