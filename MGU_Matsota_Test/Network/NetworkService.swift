//
//  NetworkService.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import Foundation
import Alamofire

//MARK: - Protocol
protocol Networking {
    
    func get(api method: API, with parameters: [String: Any],
             completion: @escaping (Data?, Error?) -> Void)
    
}







//MARK: - Class
class NetworkService {
    
    private let localError = LocalError.self
    
}









//MARK: - Protocoling
extension NetworkService: Networking {
    
    func get(api method: API, with parameters: [String : Any],
             completion: @escaping (Data?, Error?) -> Void) {
        guard let url = self.url(from: method, parameters) else {return}
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseData { (response) in
            switch response.result {
            case .success(_):
                completion(response.data, nil)
                
            case .failure(_):
                completion(nil, response.error)
            }
        }
        
    }
    
}










//MARK: - Private method
private extension NetworkService {
    
    func url(from method: API, _ parameters: [String: Any]) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme.rawValue
        components.host = API.host.rawValue
        components.path = method.rawValue
        
        var items = [URLQueryItem]()
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: "\(value)")
            items.append(item)
        }
        components.queryItems = items
        return components.url
    }
    
}
