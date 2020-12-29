//
//  NetworkManager.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import Foundation

//MARK: - Protocol
protocol NetworkManagment {
    
    func getDemo(request model: DemoRequest,
                 success: @escaping(DemoResponse) -> Void,
                 failure: @escaping(String) -> Void)
    
}







//MARK: - Class
class NetworkManager {
    
    private let localError = LocalError.self
    private let networking: Networking
    private let afError: ((Error) -> Void) = { (error) in
        debugPrint("Error: NetworkManager", error.localizedDescription)
    }
    
    init(networking: Networking) {
        self.networking = networking
    }
    
}









//MARK: - Protocoling
extension NetworkManager: NetworkManagment {
    
    func getDemo(request model: DemoRequest,
                 success: @escaping(DemoResponse) -> Void,
                 failure: @escaping(String) -> Void) {
        
        networking.get(api: .method, with: model.dictionary) { (data, error) in
            switch error {
            case .some(let error): self.afError(error)
                
            case .none:
                self.decode(received: data) { (result: DemoResponse) in
                    success(result)
                } failure: { (localizedDescription) in
                    failure(localizedDescription)
                }
            }
        }
    }
    
}

//MARK: - Private method
private extension NetworkManager {
    
    /// - Handle all `errors` if receiving them
    func decodeError(from data: Data) -> String? {
        return try? JSONDecoder().decode(ServerError.self, from: data).message
    }
    
    /// - `decode` received data in defined method with further transition of it
    func decode<T>(received data: Data?,
                   success: @escaping(T) -> Void,
                   failure: @escaping(String) -> Void) where T: Decodable {
        do {
            guard let data = data else {
                failure(localError.connection_lost.localizedDescription)
                return
            }
            if let localizedDescription = decodeError(from: data) {
                failure(localizedDescription)
            }else{
                let response = try JSONDecoder().decode(T.self, from: data)
                success(response)
            }
        }catch{
            failure(localError.unknown.localizedDescription)
        }
    }
    
}
