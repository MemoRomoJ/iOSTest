//
//  GraphProtocols.swift
//  iOSTest
//
//  Created by Guillermo Romo Jiménez on 23/09/22.
//  
//

import Foundation
import UIKit

protocol GraphViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: GraphPresenterProtocol? { get set }
    func pushDataToView(receivedData: GraphEntity)
}

protocol GraphWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createGraphModule() -> UIViewController
}

protocol GraphPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: GraphViewProtocol? { get set }
    var interactor: GraphInteractorInputProtocol? { get set }
    var wireFrame: GraphWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol GraphInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func pushDataToPresenter(receivedData: GraphEntity)
}

protocol GraphInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: GraphInteractorOutputProtocol? { get set }
    var localDatamanager: GraphLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: GraphRemoteDataManagerInputProtocol? { get set }
    
    func getData()
}

protocol GraphDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol GraphRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: GraphRemoteDataManagerOutputProtocol? { get set }
    func getExternalData()
}

protocol GraphRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func sendBackData(with entity: GraphEntity)
}

protocol GraphLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
