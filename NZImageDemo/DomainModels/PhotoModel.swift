//
//  PhotoModel.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//
struct PhotoModel: DomainModel {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Bool
    let isFriend: Bool
    let isFamily: Bool
    var imageUrl: String {
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    init(id: String,
         owner: String,
         secret: String,
         server: String,
         farm: Int,
         title: String,
         isPublic: Bool,
         isFriend: Bool,
         isFamily: Bool ) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.isPublic = isPublic
        self.isFriend = isFriend
        self.isFamily = isFamily
    }
    
    static func == (lhs: PhotoModel, rhs: PhotoModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.owner == rhs.owner &&
            lhs.secret == rhs.secret &&
            lhs.server == rhs.server &&
            lhs.farm == rhs.farm &&
            lhs.title == rhs.title &&
            lhs.isPublic == rhs.isPublic &&
            lhs.isFriend == rhs.isFriend &&
            lhs.isFamily == rhs.isFamily
    }
}
