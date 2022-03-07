//
//  EXUIImageView.swift
//  MarketPlace
//
//  Created by melaabd on 3/7/22.
//

import UIKit

var imageCache: NSCache<AnyObject, AnyObject> = {
    let cache = NSCache<AnyObject, AnyObject>()
    cache.countLimit = 10
    return cache
}()

var activityView:UIActivityIndicatorView = {
    let indecator = UIActivityIndicatorView(style: .medium)
    indecator.tintColor = .prime
   return indecator
}()

extension UIImageView {
  func loadRemoteImageFrom(url: URL) {
    image = nil
    activityView.center = self.center
    self.addSubview(activityView)
    activityView.startAnimating()
      if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
        self.image = imageFromCache
        activityView.stopAnimating()
        activityView.removeFromSuperview()
        return
    }
    URLSession.shared.dataTask(with: url) {
        data, response, error in
        DispatchQueue.main.async {
            activityView.stopAnimating()
            activityView.removeFromSuperview()
        }
          if let response = data {
              DispatchQueue.main.async {
                if let imageToCache = UIImage(data: response) {
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                    self.image = imageToCache
                }else{
                    self.loadRemoteImageFrom(url: URL(string: "https://via.placeholder.com/300/000000/FFFFFF/?text=Image%20Not%20Found")!)
                }
              }
          }
     }.resume()
  }
}
