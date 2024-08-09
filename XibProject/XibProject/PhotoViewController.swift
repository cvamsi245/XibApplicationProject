//
//  PhotoViewController.swift
//  XibProject
//
//  Created by vamsi on 30/07/24.
//

import UIKit

class PhotoViewController: UIViewController {

  
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photos: [Photo] = []{
        didSet{
            DispatchQueue.main.async {
                self.photoCollectionView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPhotos()
    }
    
    private func fetchPhotos() {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        NetworkManager.shared.fetchData(from: urlString, ofType: [Photo].self) { result in
            switch result {
            case .success(let photos):
                self.photos = photos
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension PhotoViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.photoinfo = photos[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
}
