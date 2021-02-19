//
//  ImagesController.swift
//  PicturesApp
//
//  Created by Дмитрий Григорьев on 18.02.2021.
//

import UIKit

class ImagesController {
    
    let url = URL(string: "https://picsum.photos/")
    
    static var shares = ImagesController()
    
    private init(){}
    
    
    //MARK: - загрузка рандомного изображения с сайта, а также сохранение ID и даты загрузки этого изображения
    func fetchImage(size: Int, completion: @escaping (ImageItem?, Error?) -> Void){
        let imageUrl = url?.appendingPathComponent(String(size))
        
        let task = URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
            
            if let data = data,
               let image = UIImage(data: data),
               let response = response as? HTTPURLResponse,
               let id = response.allHeaderFields["picsum-id"] as? String {
                let date = Date().toString() ?? "01.01.00 00:00:00"
                let imageItem = ImageItem(id: id, creationDate: date, image: image)
                completion(imageItem, error)
                
            } else {
                    completion(nil, error)
            }
        
        }
        task.resume()
        
    }
    //MARK: - загрузка полного изображения по ID
    func fetchFullSizeImage(id: String, completion: @escaping (UIImage?, Error?) -> ()) {
        let infoURL = url?.appendingPathComponent("id/\(id)/info")
        URLSession.shared.dataTask(with: infoURL!) { (data, response, error) in
            guard let data = data, let mime = response?.mimeType, mime == "application/json", let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let download_url = json["download_url"] as? String, let originalImageSizeUrl = URL(string: download_url)  else {
                return
            }
            do {
                let imageData = try Data(contentsOf: originalImageSizeUrl)
            let uiImage = UIImage(data: imageData)
                completion(uiImage, error)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
    }
    
    
   
    
}
