//
//  Request.swift
//  BasicFeatures
//
//  Created by Arshdeep on 2022-10-17.
//

import Foundation

class Request {
    enum APIUrl:String {
        case userList = "https://randomuser.me/api/"
    }
    
    enum HTTPMethod:String {
        case GET = "GET"
        case POST = "POST"
    }
  
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
    
    func downloadData(url: String, completion: @escaping (Data?) -> Void)  {
        let session = URLSession.shared
        guard let url = URL(string: url) else { return }
        let task = session.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
        task.resume()
    }
    
    func perform<T:Decodable>(for: T.Type = T.self, url: String, parameters: [String:Any]? = nil, method: HTTPMethod = .GET, completion: @escaping (Result<T>) -> Void)  {
        let session = URLSession.shared
        guard let url = URL(string: url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if parameters != nil {
            do {
                let json = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
                urlRequest.httpBody = json
            }
            catch let error {
                print("Error:\(error)")
            }
        }
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                   /* do {
                        if let responseJson = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                            completion(responseJson, (response as? HTTPURLResponse)?.statusCode ?? 0, (error as? NSError)?.code ?? 0)
                        }
                    }
                    catch let error {
                        print("Error:\(error)")
                    }*/
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(json))
                       // completion(json, (response as? HTTPURLResponse)?.statusCode ?? 0, (error as? NSError)?.code ?? 0)
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                }
            }
            else {
                completion(.failure(error ?? NSError(domain: "Undefined Error", code: -1)))
            }
        }
        task.resume()
    }
}
