//
//  PhotoResponseEntity.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import CommonCode
struct PhotoResponseEntity: DataEntity {
    let photos: PhotoPageEntity?
    let stat: String?
    
    //Will convert entity to domain while checking the values for appropriate property
    func toDomainModel() throws -> PhotoResponseModel{
        guard let photos = photos else {
            let context = EncodingError.Context(codingPath: [PhotoResponseEntity.CodingKeys.photos], debugDescription: "Wrong value for photos")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
       guard let stat = stat else {
            let context = EncodingError.Context(codingPath: [PhotoResponseEntity.CodingKeys.stat], debugDescription: "Wrong value for stat")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        return PhotoResponseModel(photos: try photos.toDomainModel(),
                                  stat: stat)
    }
}
