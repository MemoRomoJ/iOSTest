//  GraphRemoteDataManager.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 23/09/22.

import Foundation

class GraphRemoteDataManager:GraphRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: GraphRemoteDataManagerOutputProtocol?
    
    var data : GraphEntity?
    
    func getExternalData() {
        APIManager.manager.dataRequest(with: "https://s3.amazonaws.com/dev.structure.files/examen/ios/test.json", objectType: GraphEntity.self) { (result: Result) in
            switch result {
            case .success(let object):
                print(object)
                self.data = object
                self.remoteRequestHandler?.sendBackData(with: self.data!)
            case .failure(let error):
                print(error)
            }
        }
    }
}
