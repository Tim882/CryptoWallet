//
//  NetworkService.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 15.09.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCoinInfo<T: Decodable>(coin: String, complition: @escaping (Result<T, Error>) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    
    func getCoinInfo<T>(coin: String, complition: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(coin)/metrics") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200,
               response.statusCode >= 300 {
                complition(.failure(error ?? NetworkErrors.statusCodeError))
                return
            }
            
            guard let data = data else {
                return
            }

            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                complition(.success(obj))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
