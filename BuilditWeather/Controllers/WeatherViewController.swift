//
//  ViewController.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var viewModel:WeatherViewModel! {
        didSet{
            title = viewModel.title
        }
    }
    
    // UI Components
    var scrolView:UIScrollView!
    var viewContent:UIView!
    
    var labelCityName:UILabel!
    var labelDescription:UILabel!
    var labelTemperature:UILabel!
    var labelDay:UILabel!
    var labelTemperatureHighest:UILabel!
    var labelTemperatureLowest:UILabel!
    var labelWindSpeed:UILabel!
    var labelWindDegree:UILabel!
    var labelHumidity:UILabel!
    var labelPressure:UILabel!
    var labelPressureSeaLevel:UILabel!
    var labelPressureGroundLevel:UILabel!

    var viewSeparator1:UIView!
    var viewSeparator2:UIView!
    
    var imageViewWeather:UIImageView!
    
    var collectionViewDailyForecast:UICollectionView!
    var tableViewFutureDays:UITableView!

    
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = true
        
        viewModel = WeatherViewModel()
        
        viewModel.forecast { [weak self] in
            self?._setViewComponents()
            self?._setViewConstraints()
            
            for forecast in (self?.viewModel.weather.forecast)! {
                print(forecast)
                print("============")
            }
        }
    }
    
    private func _setViewComponents(){
        scrolView = UIScrollView()
        viewContent = UIView()
        
        labelCityName = UILabel()
        labelCityName.text = viewModel.weather.city.name
        labelCityName.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight.light)
        labelCityName.textColor = UIColor.black
        
        labelDescription = UILabel()
        labelDescription.text = "light rain".capitalized
        labelDescription.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
        labelDescription.textColor = UIColor.black
        
        
        labelTemperature = UILabel()
        labelTemperature.text = "\(Int(viewModel.weather.forecast.first!.temperature))°F"
        labelTemperature.font = UIFont.systemFont(ofSize: 100, weight: UIFont.Weight.light)
        labelTemperature.textColor = UIColor.black
        
        labelDay = UILabel()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let dayName = formatter.string(from: viewModel.weather.forecast.first!.dateTime)
        
        labelDay.text = "\(dayName) TODAY".uppercased()
        labelDay.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelDay.textColor = UIColor.black
        
        labelTemperatureHighest = UILabel()
        labelTemperatureHighest.text = "\(Int(viewModel.weather.forecast.first!.tempMax))"
        labelTemperatureHighest.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelTemperatureHighest.textColor = UIColor.black
        
        labelTemperatureLowest = UILabel()
        labelTemperatureLowest.text = "\(Int(viewModel.weather.forecast.first!.tempMin))"
        labelTemperatureLowest.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelTemperatureLowest.textColor = UIColor.darkGray
        
        viewSeparator1 = UIView()
        viewSeparator1.backgroundColor = UIColor.groupTableViewBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 56, height: 56)
        collectionViewDailyForecast = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        viewSeparator2 = UIView()
        viewSeparator2.backgroundColor = UIColor.groupTableViewBackground
        
        tableViewFutureDays = UITableView(frame: CGRect(), style: UITableViewStyle.plain)
        tableViewFutureDays.isScrollEnabled = false
        tableViewFutureDays.estimatedRowHeight = 50
        tableViewFutureDays.rowHeight = 50
        
        viewContent.addSubview(labelCityName)
        viewContent.addSubview(labelDescription)
        viewContent.addSubview(labelTemperature)
        viewContent.addSubview(labelDay)
        viewContent.addSubview(labelTemperatureHighest)
        viewContent.addSubview(labelTemperatureLowest)
        viewContent.addSubview(viewSeparator1)
        viewContent.addSubview(collectionViewDailyForecast)
        viewContent.addSubview(viewSeparator2)
        viewContent.addSubview(tableViewFutureDays)
        
        
        
        
        scrolView.addSubview(viewContent)
        view.addSubview(scrolView)
    }
    
    private func _setViewConstraints(){
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        scrolView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        scrolView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        scrolView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrolView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        viewContent.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 0).isActive = true
        viewContent.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: 0).isActive = true
        viewContent.topAnchor.constraint(equalTo: scrolView.topAnchor, constant: 0).isActive = true
        viewContent.bottomAnchor.constraint(equalTo: scrolView.bottomAnchor, constant: 0).isActive = true
        viewContent.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        viewContent.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        labelCityName.translatesAutoresizingMaskIntoConstraints = false
        labelCityName.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 16).isActive = true
        labelCityName.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor).isActive = true
        
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.topAnchor.constraint(equalTo: labelCityName.bottomAnchor, constant: 8).isActive = true
        labelDescription.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor).isActive = true
        
        labelTemperature.translatesAutoresizingMaskIntoConstraints = false
        labelTemperature.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 24).isActive = true
        labelTemperature.centerXAnchor.constraint(equalTo: viewContent.centerXAnchor).isActive = true
        
        
        labelDay.translatesAutoresizingMaskIntoConstraints = false
        labelDay.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16).isActive = true
        labelDay.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: 16).isActive = true
        
        labelTemperatureLowest.translatesAutoresizingMaskIntoConstraints = false
        labelTemperatureLowest.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16).isActive = true
        labelTemperatureLowest.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: 16).isActive = true
        
        labelTemperatureHighest.translatesAutoresizingMaskIntoConstraints = false
        labelTemperatureHighest.trailingAnchor.constraint(equalTo: labelTemperatureLowest.leadingAnchor, constant: -16).isActive = true
        labelTemperatureHighest.centerYAnchor.constraint(equalTo: labelTemperatureLowest.centerYAnchor, constant: 0).isActive = true
        
        viewSeparator1.translatesAutoresizingMaskIntoConstraints = false
        viewSeparator1.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16).isActive = true
        viewSeparator1.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16).isActive = true
        viewSeparator1.topAnchor.constraint(equalTo: labelDay.bottomAnchor, constant: 8).isActive = true
        viewSeparator1.heightAnchor.constraint(equalToConstant:1).isActive = true
        
        collectionViewDailyForecast.translatesAutoresizingMaskIntoConstraints = false
        collectionViewDailyForecast.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16).isActive = true
        collectionViewDailyForecast.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16).isActive = true
        collectionViewDailyForecast.topAnchor.constraint(equalTo: viewSeparator1.bottomAnchor, constant: 16).isActive = true
        collectionViewDailyForecast.heightAnchor.constraint(equalToConstant:56).isActive = true
        
        viewSeparator2.translatesAutoresizingMaskIntoConstraints = false
        viewSeparator2.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16).isActive = true
        viewSeparator2.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16).isActive = true
        viewSeparator2.topAnchor.constraint(equalTo: collectionViewDailyForecast.bottomAnchor, constant: 8).isActive = true
        viewSeparator2.heightAnchor.constraint(equalToConstant:1).isActive = true
        
        tableViewFutureDays.translatesAutoresizingMaskIntoConstraints = false
        tableViewFutureDays.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16).isActive = true
        tableViewFutureDays.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16).isActive = true
        tableViewFutureDays.topAnchor.constraint(equalTo: viewSeparator2.bottomAnchor, constant: 8).isActive = true
        tableViewFutureDays.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: 0).isActive = true
        
    }
    
}

