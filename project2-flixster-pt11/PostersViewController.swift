//
//  PostersViewController.swift
//  project2-flixster-pt11
//
//  Created by Omar Madjitov on 3/13/23.
//

import UIKit
import Nuke

class PostersViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // the number of items shown should be the number of albums we have.
           return posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a collection view cell (based in the identifier you set in storyboard) and cast it to our custom AlbumCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell

            // Use the indexPath.item to index into the albums array to get the corresponding album
            let poster = posters[indexPath.item]

            // Get the artwork image url
            let imageUrl = "\(poster.baseUrlString)\(poster.poster_path)"
        
        // Configure the cell with it's associated track
        cell.configure(with: poster)

            // Set the image on the image view of the cell
        Nuke.loadImage(with: URL(string: imageUrl)!, into: cell.posterImageView)

            return cell
    }
    

    var posters: [Poster] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
        // Create a search URL for fetching albums (`entity=album`)
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=44bdd86f8e10eac29f8faba26e147521")!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            
            do {
                // Create a JSON Decoder
                let decoder = JSONDecoder()
                // Try to parse the response into our custom model
                let response = try decoder.decode(PosterSearchResponse.self, from: data)
                let posters = response.results
                
                DispatchQueue.main.async{
                    self?.posters = posters
                    self?.collectionView.reloadData()
                }
                
                print("✅ \(posters)")
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }

        // Initiate the network request
        task.resume()
        print("👋 Below the closure")
        
        print(posters)

        
        // Get a reference to the collection view's layout
        // We want to dynamically size the cells for the available space and desired number of columns.
        // NOTE: This collection view scrolls vertically, but collection views can alternatively scroll horizontally.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumInteritemSpacing = 3

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumLineSpacing = 4

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width)
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // TODO: Pt 1 - Pass the selected track to the detail view controller
        // Get the cell that triggered the segue
        if let cell = sender as? UICollectionViewCell,
           
            // Get the index path of the cell from the table view
           let indexPath = collectionView.indexPath(for: cell),
           
            // Get the detail view controller
           let posterDetailViewController = segue.destination as? PosterDetailViewController {
            
            // Use the index path to get the associated track
            //let poster = poster[indexPath.row]
            
            // Use the index path to get the associated track
            let poster = posters[indexPath.item]
            
            
            
            // Set the track on the detail view controller
            posterDetailViewController.poster = poster
        }

    }
    
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get the index path for the current selected table view row (if exists)
        if let indexPath = collectionView.indexPathForSelectedRow {

            // Deselect the row at the corresponding index path
            collectionView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
