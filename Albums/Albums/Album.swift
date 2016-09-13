//
//  Album.swift
//  Albums
//
//  Created by Ben Gohlke on 9/12/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import Foundation

struct Album
{
    let title: String
    let price: String
    let thumbnailImageURL: String
    let largeImageURL: String
    let itemURL: String
    let artistURL: String
    
    let trackCount: Int
    let copyright: String
    let releaseDate: String
    
    init(name: String, price: String, thumbnailImageURL: String, largeImageURL: String, itemURL: String, artistURL: String, trackCount: Int, copyright: String, releaseDate: String)
    {
        self.title = name
        self.price = price
        self.thumbnailImageURL = thumbnailImageURL
        self.largeImageURL = largeImageURL
        self.itemURL = itemURL
        self.artistURL = artistURL
        self.trackCount = trackCount
        self.copyright = copyright
        self.releaseDate = releaseDate
        
    }
    
    static func albumsWithJSON(_ results: [Any]) -> [Album]
    {
        var albums = [Album]()
        
        if results.count > 0
        {
            for result in results
            {
                if let dictionary = result as? [String: Any]
                {
                    if let name = dictionary["collectionName"] as? String
                    {
                        var price = dictionary["formattedPrice"] as? String
                        if price == nil
                        {
                            price = dictionary["collectionPrice"] as? String
                            if price == nil
                            {
                                if let priceFloat = dictionary["collectionPrice"] as? Float
                                {
                                    let nf = NumberFormatter()
                                    nf.maximumFractionDigits = 2
                                    price = "$\(nf.string(from: NSNumber(value: priceFloat))!)"
                                }
                            }
                        }
                        
                        let thumbnailURL = dictionary["artworkUrl60"] as? String ?? ""
                        let imageURL = dictionary["artworkUrl100"] as? String ?? ""
                        let artistURL = dictionary["artistViewUrl"] as? String ?? ""
                        
                        let trackCount = dictionary["trackCount"] as? Int
                        let copyright = dictionary["copyright"] as? String
                        let releaseDate = dictionary["releaseDate"] as? String
                        
                        var itemURL = dictionary["collectionViewUrl"] as? String
                        if itemURL == nil
                        {
                            itemURL = dictionary["trackViewUrl"] as? String
                        }
                        
                        albums.append(Album(name: name, price: price!, thumbnailImageURL: thumbnailURL, largeImageURL: imageURL, itemURL: itemURL!, artistURL: artistURL, trackCount: trackCount!, copyright: copyright!, releaseDate: releaseDate!))
                    }
                }
            }
        }
        return albums
    }
}
