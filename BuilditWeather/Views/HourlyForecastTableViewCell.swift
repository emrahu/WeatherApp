//
//  HourlyForecastTableViewCell.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell {

    var labelHour:UILabel!
    var imageViewWeather:UIImageView!
    var labelTemperature:UILabel!
    var labelDescription:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setViewComponents()
        _setViewConstraints()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Can't initialize from coder")
    }
    
    private func _setViewComponents(){
        labelHour = UILabel()
        labelHour.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        labelHour.textColor = UIColor.black
        
        imageViewWeather = UIImageView()
        imageViewWeather.contentMode = .scaleAspectFit
        
        labelTemperature = UILabel()
        labelTemperature.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        labelTemperature.textColor = UIColor.white
        labelTemperature.layer.backgroundColor = UIColor.gray.cgColor
        labelTemperature.layer.cornerRadius = 8
        labelTemperature.textAlignment = .center
        
        labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelDescription.textColor = UIColor.black
        
        contentView.addSubview(labelHour)
        contentView.addSubview(imageViewWeather)
        contentView.addSubview(labelTemperature)
        contentView.addSubview(labelDescription)
    }
    
    private func _setViewConstraints(){
        labelHour.translatesAutoresizingMaskIntoConstraints = false
        labelHour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelHour.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        
        imageViewWeather.translatesAutoresizingMaskIntoConstraints = false
        imageViewWeather.leadingAnchor.constraint(equalTo: labelHour.trailingAnchor, constant: 16).isActive = true
        imageViewWeather.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        labelDescription.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        
        labelTemperature.translatesAutoresizingMaskIntoConstraints = false
        labelTemperature.trailingAnchor.constraint(equalTo: labelDescription.leadingAnchor, constant: -16).isActive = true
        labelTemperature.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        labelTemperature.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }

}
