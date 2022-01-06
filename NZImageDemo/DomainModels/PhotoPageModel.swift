//
//  PhotoPageModel.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

struct PhotoPageModel: DomainModel {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [PhotoModel]
    init(page: Int,
         pages: Int,
         perpage: Int,
         photo: [PhotoModel]) {
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.photo = photo
    }
    
    static func == (lhs: PhotoPageModel, rhs: PhotoPageModel) -> Bool {
        return lhs.page == rhs.page &&
            lhs.pages == rhs.pages &&
            lhs.perpage == rhs.perpage &&
            lhs.photo == rhs.photo
    }
}
