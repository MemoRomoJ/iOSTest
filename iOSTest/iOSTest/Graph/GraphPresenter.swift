//  GraphPresenter.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 23/09/22.

import Foundation

class GraphPresenter  {
    
    // MARK: Properties
    weak var view: GraphViewProtocol?
    var interactor: GraphInteractorInputProtocol?
    var wireFrame: GraphWireFrameProtocol?
    
}

extension GraphPresenter: GraphPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.remoteDatamanager?.getExternalData()
    }
}

extension GraphPresenter: GraphInteractorOutputProtocol {
    func pushDataToPresenter(receivedData: GraphEntity) {
        view?.pushDataToView(receivedData: receivedData)
    }
}
