//
//  APIClient.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//


import Foundation

enum APIError : Error {
    case connectionError
    case statusCodeError
}

struct MyError: LocalizedError, Equatable {
    
    private var description: String!
    private var code : Int?
    
    
    init(description: String,code : Int?) {
        self.description = description
        self.code = code
    }
    
    var errorDescription: String? {
        return description
    }
}

class APIClient {
    
    func fetchData<T:Codable>(apiRequest:APIRequest,completion:@escaping (_ result:Result<T?,Error>) -> Void) {
        let request = apiRequest.request()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Connection Error")
                completion(.failure(error!))
                return
            }
            do {
                if let httpStatusCode =  response as? HTTPURLResponse {
                    print("Status code is \(httpStatusCode.statusCode)")
                    
                    if httpStatusCode.status?.responseType == .success {
                        let model : T = try JSONDecoder().decode(T.self, from: data!)
                        completion(.success(model))
                        
                    } else {
                        completion(.failure(MyError(description: "Connection error! Please try again later.", code: nil)))
                    }
                }
                else {
                    print("Error in getting status code")
                }
            }
            catch(let parsingError){
                print("Error in parsing", parsingError)
                let clientError = NSError(domain: "Could not process your request.Please try again.", code: 111, userInfo: nil)
                completion(.failure(clientError))
            }
        }
        task.resume()
    }
}
