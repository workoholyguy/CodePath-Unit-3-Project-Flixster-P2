//
//  PosterCell.swift
//  project2-flixster-pt11
//
//  Created by Omar Madjitov on 3/13/23.
//

import UIKit
import Nuke

class PosterCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    /// Configures the cell's UI for the given track.
    func configure(with poster: Poster) {
        

        //Combine the base url and the Poster Path into one string
        let combinedPoster = "\(poster.baseUrlString)\(poster.poster_path)"
        
        // Load image async via Nuke library image loading helper method
        Nuke.loadImage(with: URL(string: combinedPoster)!, into: posterImageView)
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    
}
