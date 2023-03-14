//
//  MovieCell.swift
//  project2-flixster-pt11
//
//  Created by Omar Madjitov on 3/8/23.
//

import Nuke
import UIKit

class MovieCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Configures the cell's UI for the given track.
    func configure(with movie: Movie) {
        movieTitleLabel.text = movie.original_title
        overviewLabel.text = movie.overview

        //Combine the base url and the Poster Path into one string
        let combinedPoster = "\(movie.baseUrlString)\(movie.poster_path)"
        
        // Load image async via Nuke library image loading helper method
        Nuke.loadImage(with: URL(string: combinedPoster)!, into: movieImageView)
    }
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    

}
