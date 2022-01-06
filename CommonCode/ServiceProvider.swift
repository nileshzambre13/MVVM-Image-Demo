//
//  ServiceProvider.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import Foundation
import Network


public final class ServiceProvider<In: BaseService> {
    public typealias Service = BaseService
    private var service: In
    public init(service: In) {
        self.service = service
    }
    public func response(completion: @escaping (Data?, NZPhotoError?) -> Void) {
        switch AppSetting.shared.enviroment {
        case .live:
            urlResponse(completion: completion)
        case .mock,.failureMock:
            mockResponse(completion: completion)
        }
    }
    
    private func urlResponse(completion: @escaping (Data?, NZPhotoError?) -> Void)  {
        URLSession.shared.dataTask(with: service.request()) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, NZPhotoError.urlSessionError(error))
                } else if let data = data,
                    let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        completion(data, nil)
                    } else {
                        completion(nil, NZPhotoError.wrongStatusError(status: response.statusCode))
                    }
                } else {
                    completion(nil, NZPhotoError.urlSessionError(URLError(.badServerResponse)))
                }
            }
        }.resume()
    }
    
    private func mockResponse(completion: @escaping (Data?, NZPhotoError?) -> Void)  {
        do {
            if FileManager().fileExists(atPath: service.url) {
                let data = try Data(contentsOf: URL(fileURLWithPath: service.url))
                completion(data, nil)
            } else {
                completion(nil, NZPhotoError.urlSessionError(URLError(.fileDoesNotExist)))
            }
        } catch {
            completion(nil, NZPhotoError.urlSessionError(URLError(.badServerResponse)))
        }
    }
}

