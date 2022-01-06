//
//  PhotoPageEntity.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
import UIKit
import CommonCode
struct PhotoPageEntity: DataEntity {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let photo: [PhotoEntity]?
    
    //Will convert entity to domain while checking the values for appropriate property
    func toDomainModel() throws -> PhotoPageModel{
        guard let page = page else {
            let context = EncodingError.Context(codingPath: [PhotoPageEntity.CodingKeys.page], debugDescription: "Wrong value for page")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        guard let pages = pages else {
            let context = EncodingError.Context(codingPath: [PhotoPageEntity.CodingKeys.pages], debugDescription: "Wrong value for pages")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        guard let perpage = perpage else {
            let context = EncodingError.Context(codingPath: [PhotoPageEntity.CodingKeys.perpage], debugDescription: "Wrong value for perpage")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        guard let photo = photo else {
            let context = EncodingError.Context(codingPath: [PhotoPageEntity.CodingKeys.photo], debugDescription: "Wrong value for photo")
            throw NZPhotoError.parseError(EncodingError.invalidValue("", context) as NSError)
        }
        return PhotoPageModel(page: page,
                              pages: pages,
                              perpage: perpage,
                              photo: try photo.toDomainModel())
    }
}
