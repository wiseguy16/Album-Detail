//
//  AlbumDetailViewController.swift
//  Albums
//
//  Created by Gregory Weiss on 9/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController
{

    var anAlbum: Album!
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
       // self.window = UIWindow(frame: UIScreen.main.bounds)
        //var view = UIWindow()
        //self.view.frame = self.size.bounds
        
        
       // configureView()
        
        let trackCountLabel = UILabel(frame: CGRect(x:30, y:60, width: 260, height: 50))
        trackCountLabel.text = "Number of tracks: \(anAlbum.trackCount)"
        self.view.addSubview(trackCountLabel)
        
        let copyrightLabel = UILabel(frame: CGRect(x:30, y:100, width: 260, height: 50))
        copyrightLabel.numberOfLines = 0
        copyrightLabel.text = anAlbum.copyright
        self.view.addSubview(copyrightLabel)
        
        let releaseDateLabel = UILabel(frame: CGRect(x:30, y:450, width: 200, height: 50))
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.text = "Released Date: \(anAlbum.releaseDate)"
        self.view.addSubview(releaseDateLabel)
      
        
        var bigImageView : UIImageView
        bigImageView  = UIImageView(frame: CGRect(x:70, y:170, width: 200, height: 200))
        
        let request = URLRequest(url: URL(string: anAlbum.largeImageURL)!)
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            if error == nil
            {
                let image = UIImage(data: data!)
                let queue = DispatchQueue.main
                queue.async {
                    //if let cellToUpdate = tableView.cellForRow(at: indexPath) as? AlbumCell
                    //{
                     //   cellToUpdate.activityView.stopAnimating()
                        bigImageView.image = image
                   // }
                }
            }
            else
            {
                print("Error \(error?.localizedDescription)")
            }
        }).resume()
        
       // bigImageView.image = UIImage(named:anAlbum.largeImageURL)
        self.view.addSubview(bigImageView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func configureView()
    {
        detailNameLabel.text = aMusician.name
        detailMoneyLabel.text = aMusician.paymentPerShow
        detailBioLabel.text = aMusician.bio
        detailFoundedLabel.text = aMusician.foundedOrBorn
        detailImage.image = UIImage(named: "\(aMusician.musicianImage).jpg")
        detailFinePrintLabel.text = "Source: 'List of the highest grossing concert tours'. The list for the tour was obtained from Billboard and Pollstar with sales information from promoters and managers who organized the tours."
        
    }
 */

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
