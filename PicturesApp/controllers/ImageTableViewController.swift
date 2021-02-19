//
//  ImageTableViewController.swift
//  PicturesApp
//
//  Created by Дмитрий Григорьев on 18.02.2021.
//

import UIKit

class ImageTableViewController: UITableViewController {
    
    
    var images = [ImageItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
    }
    
   //MARK: - если отображается последняя ячейка таблицы. Подгрузить еще изображения
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = indexPath.row
        if lastIndex == images.count - 1 {
            fetchImages()
        }
    }
    
    
    func fetchImages(){
        for _ in 0..<5 {
            ImagesController.shares.fetchImage(size: 40) { (image, error) in
                guard let image = image else {return}
                self.images.append(image)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
  
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCellIdentifier", for: indexPath)

        let imageItem = images[indexPath.row]
        cell.textLabel?.text = String("id: \(imageItem.id)")
        
        cell.imageView?.image = imageItem.image
        

        return cell
    }
    
    //MARK: - Для более детального просмотра изображений подгружается новое изображение по ID
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DetailImage" else {return}
        let detailImageVC = segue.destination as! DetailImageViewController
        let selectedRow = tableView.indexPathForSelectedRow!.row
        var imageItem = images[selectedRow]
        ImagesController.shares.fetchFullSizeImage(id: imageItem.id) { (image, error) in
            if let image = image {
                imageItem.image = image
                detailImageVC.imageItem = imageItem
            }
        }
        
    }

    //MARK: - При отсутствии интернета подгружает изображения вручную, если они отсутствуют
    @IBAction func refreshClicked(_ sender: UIBarButtonItem) {
        if images.count == 0 {
            fetchImages()
        } else {
            tableView.reloadData()
        }
        
    }
}
