//
//  NZPhotoCell.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 24/12/22.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
import Downloader

class NZPhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    private var cancelDownload: CancelDowloading?
    private var photoDownloader: PhotoDownloader?
    private var photoModel: PhotoModel?
    private var iNZownloading: Bool = true
    private let activityIndicator: UIActivityIndicatorView =  UIActivityIndicatorView(style: .medium)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        //You Code here
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLoader()
    }
    
    private func setupLoader() {
        addSubview(activityIndicator)
        activityIndicator.center = self.center
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopDownloading()
        imageView.image = nil
        photoDownloader = nil
        self.cancelButton.setImage(UIImage(named: "close"), for: .normal)
    }
    
    func setPhoto(photoModel: PhotoModel){
        self.photoModel = photoModel
        photoDownloader = PhotoDownloader(maxCacheTimeInHour: 1, URLCache: CacheHandler.sharedHandler.cache)
        startDownloading()
    }
    
    private func startDownloading() {
        activityIndicator.startAnimating()
        guard let photoModel = photoModel else { return }
        cancelDownload = photoDownloader?.loadImage(with: photoModel.imageUrl, completion: {[weak self] downloadResult in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            switch downloadResult {
            case let .success(image):
                self.imageView.image = image
            case .noData, .error, .userCancelled:
                self.imageView.image =  UIImage(named: "error")
            }
        })
    }
    
    private func stopDownloading() {
        cancelDownload?()
    }
    
    @IBAction func pauseResumeAction(_ sender: Any) {
        iNZownloading ? stopDownloading() : startDownloading()
        let buttonImage = iNZownloading
            ? UIImage(systemName: "square.and.arrow.down.fill")
            : UIImage(named: "close")
        self.cancelButton.setImage(buttonImage,for: .normal)
        iNZownloading = !iNZownloading
    }
}
