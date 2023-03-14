//
//  PosterDetailViewController.swift
//  project2-flixster-pt11
//
//  Created by Omar Madjitov on 3/13/23.
//

import Nuke
import Foundation
import UIKit

class PosterDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var voteNumLabel: UILabel!
    
    @IBOutlet weak var countNumLabel: UILabel!
    
    @IBOutlet weak var popNumLabel: UILabel!
    
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var poster: Poster!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // TODO: Pt 1 - Configure the UI elements with the passed in track
        
        //*************************************************************************************
        
        
        //Combine the base url and the Poster Path into one string
        let combinedBackdrop = "\(poster.baseUrlString)\(poster.backdrop_path)"
        
        // Load image async via Nuke library image loading helper method
        Nuke.loadImage(with: URL(string: combinedBackdrop)!, into: movieImageView)
        
        // Set labels with the associated track values.
        movieTitleLabel.text = poster.original_title
        overviewLabel.text = poster.overview
        
        //double
        voteNumLabel.text = String(poster.vote_average)
        
        //int
        countNumLabel.text = String(poster.vote_count)
        
        //double
        popNumLabel.text = String(poster.popularity)
        
        //*************************************************************************************
    }
}
