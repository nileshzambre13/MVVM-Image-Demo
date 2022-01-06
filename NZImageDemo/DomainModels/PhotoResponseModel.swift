//
//  PhotoResponseModel.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
struct PhotoResponseModel: DomainModel {
    let photos: PhotoPageModel
    let stat: String
    init(photos: PhotoPageModel,
         stat: String) {
        self.photos = photos
        self.stat = stat
    }
    
    static func == (lhs: PhotoResponseModel, rhs: PhotoResponseModel) -> Bool {
        return lhs.photos == rhs.photos &&
            lhs.stat == rhs.stat
    }
}
