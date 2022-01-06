//
//  NZPhotoLibraryViewController.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
import CommonCode
import Downloader

class NZPhotoLibraryViewController: BaseViewController {
    private var photos: [PhotoModel] = []
    private var photoViewModel: NZVPhotoViewModel?
    @IBOutlet var photoCollection: UICollectionView!
    override class var storyboardName: String{ "NZPhotoLibrary"  }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        loadPhotos()
    }
    private func bindViewModel() {
        photoViewModel = NZVPhotoViewModel()
        guard let photoViewModel = photoViewModel else { return }
        photoViewModel.startLoading = { [weak self] in
            self?.startLoading()
        }
        photoViewModel.stopLoading = {[weak self] in
            self?.stopLoading()
        }
        photoViewModel.successResponse = { [weak self] in
            guard let self = self else { return }
            self.displayPhotos(photos: photoViewModel.photos)
        }
        photoViewModel.failureResponse = { [weak self] in
            guard let self = self,
                  let photoError = photoViewModel.photoError else { return }
            self.displayError(title: "Error", message: photoError)
        }
    }
}

extension NZPhotoLibraryViewController {
    func displayPhotos(photos: [PhotoModel]) {
        self.photos = photos
        photoCollection.reloadData()
    }
}

extension NZPhotoLibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "NZPhotoCell", for: indexPath) as?  NZPhotoCell else {
                    return UICollectionViewCell()
                }
        cell.setPhoto(photoModel: photos[indexPath.item])
        return cell
    }
}

extension NZPhotoLibraryViewController: UICollectionViewDelegate { }
extension NZPhotoLibraryViewController: UISearchBarDelegate {
    private func loadPhotos() {
        photoViewModel?.loadRecentPhotos()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
        photoViewModel?.searchPhoto(with: searchBar.text ?? "")
    }
}
