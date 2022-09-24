//  APIManager.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 24/09/22.

import Foundation

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

class APIManager{
    static let manager = APIManager()

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
            
            print(data.hashValue)
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

}
