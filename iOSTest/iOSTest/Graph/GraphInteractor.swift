//
//  GraphInteractor.swift
//  iOSTest
//
//  Created by Guillermo Romo Jiménez on 23/09/22.
//  
//

import Foundation

class GraphInteractor: GraphInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: GraphInteractorOutputProtocol?
    var localDatamanager: GraphLocalDataManagerInputProtocol?
    var remoteDatamanager: GraphRemoteDataManagerInputProtocol?

}

extension GraphInteractor: GraphRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
