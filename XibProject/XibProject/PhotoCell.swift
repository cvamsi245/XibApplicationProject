//
//  PhotoCell.swift
//  XibProject
//
//  Created by vamsi on 30/07/24.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var Image: UIImageView!
    
    var photoinfo: Photo?{
        didSet{
            photoinfo?.thumbnailUrl?.stringToImage({ [weak self] image in
                DispatchQueue.main.async {
                    self?.Image.image = image
                }
            })
        }
    }
   
}
