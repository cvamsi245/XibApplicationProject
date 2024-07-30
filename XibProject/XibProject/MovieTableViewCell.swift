//
//  MovieTableViewCell.swift
//  XibProject
//
//  Created by vamsi on 29/07/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var stackviewHidden: UIStackView!
    @IBOutlet weak var ViewCards: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTittle: UILabel!
    @IBOutlet weak var movieType: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieIMDI: UILabel!
    
    var movie: Search?{
        didSet{
            movieTittle.text = "Title: \(movie?.title ?? "")"
            movieType.text = "Type: \(movie?.type ?? "")"
            movieYear.text = "Year: \(movie?.year ?? "")"
            movieIMDI.text = "IMDI: \(movie?.imdbID ?? "")"
            movie?.poster?.stringToImage({
                [weak self] image in
                DispatchQueue.main.async {
                    self?.posterImage.image = image
                }
            })
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewCards.layer.shadowColor = UIColor.gray.cgColor
        ViewCards.layer.shadowOffset = CGSize(width: 0, height: 0)
        ViewCards.layer.shadowOpacity = 1.0
        ViewCards.layer.masksToBounds = false
        ViewCards.layer.cornerRadius = 2.0
       // stackviewHidden.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension String {
    
    func stringToImage(_ handler: @escaping ((UIImage?)->())) {
        if let url = URL(string: self) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    handler(image)
                }
            }.resume()
        }
    }
}
