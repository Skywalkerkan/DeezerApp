//
//  AddSubviews+Extension.swift
//  DeezerApp
//
//  Created by Erkan on 9.05.2023.
//

import Foundation
import UIKit



extension UIView{
    
    func addSubviews(views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
    
}
