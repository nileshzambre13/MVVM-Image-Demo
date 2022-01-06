//
//  NZPhotoService.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import Foundation
import Network
import CommonCode

let api_key = "3aaeaf09d9e52f7176b08551731ad5b6"
let secret = "abe8bd114ca9289f"

enum NZPhotoService {
    case getRecent
    case searchPhotos(text:String = "")
}
extension NZPhotoService: BaseService{
    var mockName: String {
        switch self {
        case .searchPhotos:
            return "/searchPhotos.json"
        case .getRecent:
            return "/recentPhotos.json"
        }
    }
    var failureMock: String {
       return "/error.json"
    }
    
    var host: String {
        switch AppSetting.shared.enviroment {
        case .live:
            return "https://www.flickr.com/services/"
        case .mock, .failureMock:
            return Bundle.main.bundlePath
        }
    }
    
    var path: String {
        switch self {
        case .getRecent,
             .searchPhotos:
            return  "/rest"
        }
    }
    
    var restMethod: String {
        switch self {
        case .getRecent:
            return  "flickr.photos.getrecent"
        case .searchPhotos:
            return  "flickr.photos.search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecent,
             .searchPhotos:
            return .get
        }
    }
    var parameters: [String: String] {
        var params = ["format":"json",
                      "nojsoncallback":"1",
                      "method":restMethod,
                      "api_key": api_key]
        switch self {
        case let .searchPhotos(text: text):
            params["text"] = text
        case  .getRecent: break
        }
        return params
    }
    
}
