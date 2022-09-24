//
//  GraphWireFrame.swift
//  iOSTest
//
//  Created by Guillermo Romo Jiménez on 23/09/22.
//  
//

import Foundation
import UIKit

class GraphWireFrame: GraphWireFrameProtocol {

    class func createGraphModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "GraphView")
        if let view = navController.children.first as? GraphView {
            let presenter: GraphPresenterProtocol & GraphInteractorOutputProtocol = GraphPresenter()
            let interactor: GraphInteractorInputProtocol & GraphRemoteDataManagerOutputProtocol = GraphInteractor()
            let localDataManager: GraphLocalDataManagerInputProtocol = GraphLocalDataManager()
            let remoteDataManager: GraphRemoteDataManagerInputProtocol = GraphRemoteDataManager()
            let wireFrame: GraphWireFrameProtocol = GraphWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "GraphView", bundle: Bundle.main)
    }
    
}
