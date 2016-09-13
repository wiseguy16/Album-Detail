//
//  AlbumDataProvider.swift
//  Albums
//
//  Created by Gregory Weiss on 9/13/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import Foundation
import UIKit

class AlbumDataProvider: NSObject
{
    weak var tableView: UITableView!
    var albums = [Album]()
    var api: APIController!
    
    override init()
    {
        super.init()
        api = APIController(delegate: self)
        api.searchItunesFor("Beatles")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    func setAndRegisterNib(tableView: UITableView)
    {
        self.tableView = tableView
        tableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")

    }

}

extension AlbumDataProvider: AlbumDataProviderProtocol
{
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albums.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        
        let album = albums[indexPath.row]
        
        // cell.imageView?.image = UIImage(named: "Blank44")
        //  cell.artworkImageView.image = UIImage(named: "Blank66")
        cell.artworkImageView.image = nil
        cell.titleLabel?.text = album.title
        cell.priceLabel.text = album.price
        
        cell.activityView.startAnimating()
        
        let request = URLRequest(url: URL(string: album.thumbnailImageURL)!)
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            if error == nil
            {
                let image = UIImage(data: data!)
                let queue = DispatchQueue.main
                queue.async {
                    if let cellToUpdate = tableView.cellForRow(at: indexPath) as? AlbumCell
                    {
                        cellToUpdate.activityView.stopAnimating()
                        cellToUpdate.artworkImageView.image = image
                    }
                }
            }
            else
            {
                print("Error \(error?.localizedDescription)")
            }
        }).resume()
        
        
        
        return cell
    }
   
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let destVC = UIViewController() as! AlbumDetailViewController
        
        
        
       // navigationController?.pushViewController(destVC, animated: true)
        let detailAlbum = albums[indexPath.row]
        destVC.anAlbum = detailAlbum
    }
*/
    
    
    
    func didReceiveAPIResults(_ results: [Any])
    {
        let queue = DispatchQueue.main
        queue.async {
            self.albums = Album.albumsWithJSON(results)
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    
}
