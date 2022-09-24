//  GraphInteractor.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 23/09/22.

import Foundation

class GraphInteractor: GraphInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: GraphInteractorOutputProtocol?
    var localDatamanager: GraphLocalDataManagerInputProtocol?
    var remoteDatamanager: GraphRemoteDataManagerInputProtocol?
    
    var graphData : GraphEntity?

    func getData() {
        remoteDatamanager?.getExternalData()
    }
}

extension GraphInteractor: GraphRemoteDataManagerOutputProtocol {
    func sendBackData(with entity: GraphEntity) {
        presenter?.pushDataToPresenter(receivedData: entity)
    }
}
