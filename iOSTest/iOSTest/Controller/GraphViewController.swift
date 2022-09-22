//  GraphViewController.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 21/09/22.

import UIKit

class GraphViewController: UIViewController {
    //AppError enum which shows all possible errors
    enum AppError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }

    //Result enum to show success or failure
    enum Result<T> {
        case success(T)
        case failure(AppError)
    }

    //dataRequest which sends request to given URL and convert to Decodable Object
    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        //create the url with NSURL
        let dataURL = URL(string: url)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(Result.failure(AppError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(AppError.dataNotFound))
                return
            }
            
            print(data.description)
            print(response!.description)
            do {
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(AppError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        // aqui consultar el API y mostrar grafica
        dataRequest(with: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld", objectType: ApiObj.self) { (result: Result) in
            switch result {
            case .success(let object):
                print(object)
            case .failure(let error):
                print(error)
            }
        }
    }

}
