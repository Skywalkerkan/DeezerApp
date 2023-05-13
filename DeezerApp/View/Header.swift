//
//  Header.swift
//  DeezerApp
//
//  Created by Erkan on 12.05.2023.
//

import UIKit
import Alamofire

class MyHeaderFooterClass: UICollectionReusableView {

    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
 override init(frame: CGRect) {
    super.init(frame: frame)
    //self.backgroundColor = UIColor.purple
    // translatesAutoresizingMaskIntoConstraints = false
     addSubview(imageView)
     imageView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: 0)

    // Customize here

 }

 required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

 }
    
    func fetchImage(imageURL: String){
        
        guard let imageURL = URL(string: imageURL) else{return}
        
        AF.request(imageURL).responseData { response in
            switch response.result{
            case .success(let imageData):
               // completion(.success(imageData))
                self.imageView.image = UIImage(data: imageData)
            case .failure(let error):
               // completion(.failure(error))
                print("Error")
                
            }
        }
        
        
        
    }
}
