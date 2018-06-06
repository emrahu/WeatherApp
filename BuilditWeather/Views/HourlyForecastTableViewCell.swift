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
    var labelDetails:UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setViewComponents()
        _setViewConstraints()
    
        selectionStyle = .none
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
        imageViewWeather.backgroundColor = UIColor.clear
        
        labelTemperature = UILabel()
        labelTemperature.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        labelTemperature.textColor = UIColor.white
        labelTemperature.layer.backgroundColor = UIColor.gray.cgColor
        labelTemperature.layer.cornerRadius = 8
        labelTemperature.textAlignment = .center
        
        labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelDescription.textColor = UIColor.black
        
        labelDetails = UILabel()
        labelDetails.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        labelDetails.textColor = UIColor.darkGray
        labelDetails.numberOfLines = 0
        
        contentView.addSubview(labelHour)
        contentView.addSubview(imageViewWeather)
        contentView.addSubview(labelTemperature)
        contentView.addSubview(labelDescription)
        contentView.addSubview(labelDetails)
    }
    
    private func _setViewConstraints(){
        labelHour.translatesAutoresizingMaskIntoConstraints = false
        labelHour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelHour.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        
        imageViewWeather.translatesAutoresizingMaskIntoConstraints = false
        imageViewWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90).isActive = true
        imageViewWeather.centerYAnchor.constraint(equalTo: labelHour.centerYAnchor, constant: 0).isActive = true
        imageViewWeather.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageViewWeather.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        labelDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        
        labelTemperature.translatesAutoresizingMaskIntoConstraints = false
        labelTemperature.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        labelTemperature.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 8).isActive = true
        labelTemperature.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        labelDetails.translatesAutoresizingMaskIntoConstraints = false
        labelDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        labelDetails.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: 8).isActive = true
        labelDetails.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }

}
