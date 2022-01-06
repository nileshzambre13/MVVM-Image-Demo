//
//  NZVPhotoViewModel.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 05/01/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import Foundation
import Downloader
import CommonCode

class NZVPhotoViewModel: NSObject {
    var successResponse: (() -> ()) = {}
    var failureResponse: (() -> ()) = {}
    var startLoading: (() -> ()) = {}
    var stopLoading: (() -> ()) = {}
    private(set) var photos: [PhotoModel] = [] {
        didSet {
            self.successResponse()
        }
    }
    private(set) var photoError: String? {
        didSet {
            self.failureResponse()
        }
    }
    func loadRecentPhotos() {
        CacheHandler.sharedHandler.setupCache(memoryInMB: 100, diskCapacityInMB: 100)
        startLoading()
        let serviceProvider = ServiceProvider<NZPhotoService>(service: .getRecent)
        serviceProvider.response { [weak self] (data, error) in
            guard let self = self else { return }
            self.stopLoading()
            do {
                if let error = error {
                    self.photoError = self.getErrorString(error: error)
                } else if let data = data {
                    let response = try JSONDecoder()
                        .decode(PhotoResponseEntity.self, from: data).toDomainModel()
                    self.photos = response.photos.photo
                } else {
                    self.photoError = self.getErrorString(error: NZPhotoError.parseError(URLError(.badServerResponse)))
                }
            }
            catch {
                self.photoError =  self.getErrorString(error: NZPhotoError.parseError(error))
            }
        }
    }
    func searchPhoto(with text: String) {
        CacheHandler.sharedHandler.setupCache(memoryInMB: 100, diskCapacityInMB: 100)
        startLoading()
        let serviceProvider = ServiceProvider<NZPhotoService>(service: .searchPhotos(text: text))
        serviceProvider.response { [weak self] (data, error) in
            guard let self = self else { return }
            self.stopLoading()
            do {
                if let error = error {
                    self.photoError = self.getErrorString(error: error)
                } else if let data = data {
                    let response = try JSONDecoder()
                        .decode(PhotoResponseEntity.self, from: data).toDomainModel()
                    self.photos = response.photos.photo
                } else {
                    self.photoError = self.getErrorString(error: NZPhotoError.parseError(URLError(.badServerResponse)))
                }
            }
            catch {
                self.photoError = self.getErrorString(error: NZPhotoError.parseError(error))
            }
        }
    }
    
    func getErrorString(error: NZPhotoError ) -> String {
        switch error {
        case let .parseError(error):
            return error.localizedDescription
        case let .urlSessionError(error):
            return error.localizedDescription
        case let .wrongStatusError(status: status):
            return "request failed with status \(status)"
        }
    }
}
