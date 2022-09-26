//  GraphViewModel.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 25/09/22.

import Foundation

final class GraphViewModel: ObservableObject {
    
    var dataModel : GraphModel?
    
    init(){
        getGraphData()
    }
    
    func getGraphData() {
        APIManager.manager.dataRequest(with: APIRoute, objectType: GraphModel.self) { (result: Result) in
            switch result {
            case .success(let object):
                print(object)
                self.dataModel = object
            case .failure(let error):
                print(error)
            }
        }
    }
}
