//
//  PhotoEntity.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import CommonCode
struct PhotoEntity: DataEntity {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
    
    //Will convert entity to domain while checking the values for appropriate property
    func toDomainModel() throws -> PhotoModel{
        guard let id = id else {
            let context = EncodingError.Context(codingPath: [PhotoEntity.CodingKeys.id],
                                                debugDescription: "Wrong value for id")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        guard let owner = owner else {
            let context = EncodingError.Context(codingPath: [PhotoEntity.CodingKeys.owner],
                                                debugDescription: "Wrong value for owner")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        guard let secret = secret else {
            let context = EncodingError.Context(codingPath: [PhotoEntity.CodingKeys.secret],
                                                debugDescription: "Wrong value for secret")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        guard let server = server else {
            let context = EncodingError.Context(codingPath: [PhotoEntity.CodingKeys.server], debugDescription: "Wrong value for server")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        
        guard let farm = farm else {
            let context = EncodingError.Context(codingPath: [PhotoEntity.CodingKeys.farm],
                                                debugDescription: "Wrong value for farm")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        guard let title = title else {
            let context = EncodingError.Context(codingPath: [PhotoEntity.CodingKeys.title],
                                                debugDescription: "Wrong value for title")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        return PhotoModel(id: id,
                          owner: owner,
                          secret: secret,
                          server: server,
                          farm: farm,
                          title: title,
                          isPublic: ispublic ?? 0 > 0,
                          isFriend: isfriend ?? 0 > 0,
                          isFamily: isfamily ?? 0 > 0)
    }
}
