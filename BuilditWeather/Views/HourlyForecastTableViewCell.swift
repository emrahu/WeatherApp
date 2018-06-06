//
//  HourlyForecastTableViewCell.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/5/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell {

    var labelDay:UILabel!
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
        labelDay = UILabel()
        labelDay.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        labelDay.textColor = UIColor.black
        
        imageViewWeather = UIImageView()
        imageViewWeather.contentMode = .scaleAspectFit
        imageViewWeather.backgroundColor = UIColor.clear
        
        labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelDescription.textColor = UIColor.black
        labelDescription.textAlignment = .right
        
        labelTemperature = UILabel()
        labelTemperature.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        labelTemperature.textColor = UIColor.white
        labelTemperature.layer.backgroundColor = UIColor.gray.cgColor
        labelTemperature.layer.cornerRadius = 8
        labelTemperature.textAlignment = .center
        
        labelDetails = UILabel()
        labelDetails.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        labelDetails.textColor = UIColor.darkGray
        labelDetails.numberOfLines = 0
        
        contentView.addSubview(labelDay)
        contentView.addSubview(imageViewWeather)
        contentView.addSubview(labelTemperature)
        contentView.addSubview(labelDescription)
        contentView.addSubview(labelDetails)
    }
    
    private func _setViewConstraints(){
        labelDay.translatesAutoresizingMaskIntoConstraints = false
        labelDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelDay.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        
        imageViewWeather.translatesAutoresizingMaskIntoConstraints = false
        imageViewWeather.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90).isActive = true
        imageViewWeather.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        imageViewWeather.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageViewWeather.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.centerYAnchor.constraint(equalTo: labelDay.centerYAnchor, constant: 0).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        labelTemperature.translatesAutoresizingMaskIntoConstraints = false
        labelTemperature.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        labelTemperature.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45).isActive = true
        labelTemperature.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        labelDetails.translatesAutoresizingMaskIntoConstraints = false
        labelDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        labelDetails.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: 8).isActive = true
        labelDetails.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
}
