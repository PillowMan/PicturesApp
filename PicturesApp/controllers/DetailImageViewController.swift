//
//  DetailImageViewController.swift
//  PicturesApp
//
//  Created by Дмитрий Григорьев on 18.02.2021.
//

import UIKit

class DetailImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadDate: UILabel!
    
    var imageItem: ImageItem? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        guard let imageItem = imageItem else {
            return
        }
        DispatchQueue.main.async {
            self.imageView.image = imageItem.image
            print(imageItem.image.size)
            self.downloadDate.text = "Download date: \(imageItem.creationDate)"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
