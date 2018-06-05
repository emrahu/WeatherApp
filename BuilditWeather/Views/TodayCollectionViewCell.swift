//
//  TodayCollectionViewCell.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell {
    var labelHour:UILabel!
    var imageViewWeather:UIImageView!
    var labelTemperature:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _setViewComponents()
        _setViewConstraints()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Can't initialize from coder")
    }
    
    private func _setViewComponents(){
        labelHour = UILabel()
        labelHour.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        labelHour.textColor = UIColor.black
        
        imageViewWeather = UIImageView()
        imageViewWeather.contentMode = .scaleAspectFit
        imageViewWeather.backgroundColor = UIColor.groupTableViewBackground
        
        labelTemperature = UILabel()
        labelTemperature.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        labelTemperature.textColor = UIColor.black
        
        contentView.addSubview(labelHour)
        contentView.addSubview(imageViewWeather)
        contentView.addSubview(labelTemperature)
        
        
    }
    private func _setViewConstraints(){
        labelHour.translatesAutoresizingMaskIntoConstraints = false
        labelHour.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        labelHour.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
        imageViewWeather.translatesAutoresizingMaskIntoConstraints = false
        imageViewWeather.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        imageViewWeather.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        imageViewWeather.widthAnchor.constraint(equalToConstant: 56).isActive = true
        imageViewWeather.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        labelTemperature.translatesAutoresizingMaskIntoConstraints = false
        labelTemperature.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        labelTemperature.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
    }
}
