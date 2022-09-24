//  GraphWireFrame.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 23/09/22.

import Foundation
import UIKit

class GraphWireFrame: GraphWireFrameProtocol {

    class func createGraphModule() -> UIViewController {
        let view = GraphView()
        
        let presenter: GraphPresenterProtocol & GraphInteractorOutputProtocol = GraphPresenter()
        let interactor: GraphInteractorInputProtocol & GraphRemoteDataManagerOutputProtocol = GraphInteractor()
        let remoteDataManager: GraphRemoteDataManagerInputProtocol = GraphRemoteDataManager()
        let wireFrame: GraphWireFrameProtocol = GraphWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
        
    }
}
