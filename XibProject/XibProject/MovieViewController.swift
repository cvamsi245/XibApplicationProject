//
//  ViewController.swift
//  XibProject
//
//  Created by vamsi on 29/07/24.
//

import UIKit

final class MovieViewController: UIViewController {
    
    @IBOutlet weak var MovieTableView: UITableView!
    
    var movies: [Search] = []{
        didSet{
            DispatchQueue.main.async {
                self.MovieTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        MovieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    private func fetchMovies() {
        let urlString = "http://www.omdbapi.com/?apikey=e5311742&s=Batman&page=1"
        NetworkManager.shared.fetchData(from: urlString, ofType: Movie.self) { result in
            switch result {
            case .success(let movies):
                self.movies = movies.search ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
}
extension MovieViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = MovieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        cell.movie = movies[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = MovieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell
        cell?.stackviewHidden.isHidden  = false
        DispatchQueue.main.async {
            self.MovieTableView.reloadData()
        }
    }*/
    
}
