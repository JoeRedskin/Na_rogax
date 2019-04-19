//
//  ImageDiscTableViewCell.swift
//  NaRogax
//
//  Created by User on 09/04/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import UIKit

class ImageDiscTableViewCell: UITableViewCell {

    @IBOutlet weak var imageDish: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var descriptionSpinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(dish: DishDescription){
        if dish.name == "" {
            labelName.text = "Без наимменования"
        } else {
            labelName.text = dish.name
        }
        
        if dish.photo == "" || dish.photo == nil {
            imageDish.image = UIImage(named: "no_image")
        } else {
            fetchImage(url_img: dish.photo!)
        }
    }
    
    private func fetchImage(url_img: String) {
        if let url = URL(string: url_img){
            descriptionSpinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents {
                        self?.imageDish.image = UIImage(data: imageData)
                        self?.descriptionSpinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    
}
