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
    var constraintTableViewheight:NSLayoutConstraint!

    let dateFormatter = DateFormatter()
    
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = true
        
        viewModel = WeatherViewModel()
        
        self._setViewComponents()
        self._setViewConstraints()
        
        
        viewModel.forecast { [weak self] (success, error) in
            if success {
                self?._updateComponentValues()
                self?.dateFormatter.dateFormat = "EEEE"
            } else {
                let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self?.present(alert, animated: true, completion: nil)
            }
        }
        tableViewFutureDays.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableViewFutureDays.layer.removeAllAnimations()
        
        UIView.animate(withDuration: 0.2) {
            self.labelCityName.alpha = 1.0
            self.labelTemperature.alpha = 1.0
            self.collectionViewDailyForecast.alpha = 1.0
            self.updateViewConstraints()
            self.view.layoutIfNeeded()
        }
    }
    
    
    private func _setViewComponents(){
        
        scrolView = UIScrollView()
        scrolView.showsHorizontalScrollIndicator = false
        
        viewContent = UIView()
        
        labelCityName = UILabel()
        labelCityName.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight.light)
        labelCityName.textColor = UIColor.black
        labelCityName.textAlignment = .center
        labelCityName.adjustsFontSizeToFitWidth = true
        labelCityName.minimumScaleFactor = 0.5
        labelCityName.alpha = 0
        
        labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
        labelDescription.textColor = UIColor.black
        labelDescription.textAlignment = .center
        
        labelTemperature = UILabel()
        labelTemperature.font = UIFont.systemFont(ofSize: 100, weight: UIFont.Weight.light)
        labelTemperature.textColor = UIColor.black
        labelTemperature.textAlignment = .center
        labelTemperature.alpha = 0
        
        labelDay = UILabel()
        labelDay.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelDay.textColor = UIColor.black
        
        labelTemperatureHighest = UILabel()
        labelTemperatureHighest.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelTemperatureHighest.textColor = UIColor.black
        
        labelTemperatureLowest = UILabel()
        labelTemperatureLowest.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        labelTemperatureLowest.textColor = UIColor.darkGray
        labelTemperatureHighest.textAlignment = .right
        
        viewSeparator1 = UIView()
        viewSeparator1.backgroundColor = UIColor.groupTableViewBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 56, height: 86)
        collectionViewDailyForecast = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionViewDailyForecast.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: viewModel.cellIdentifier)
        collectionViewDailyForecast.backgroundColor = UIColor.white
        collectionViewDailyForecast.showsHorizontalScrollIndicator = false
        collectionViewDailyForecast.alpha = 0
        viewSeparator2 = UIView()
        viewSeparator2.backgroundColor = UIColor.groupTableViewBackground
        
        tableViewFutureDays = UITableView(frame: CGRect(), style: UITableViewStyle.plain)
        tableViewFutureDays.isScrollEnabled = false
        tableViewFutureDays.estimatedRowHeight = 150
        tableViewFutureDays.rowHeight = UITableViewAutomaticDimension
        tableViewFutureDays.tableFooterView = UIView()
        tableViewFutureDays.register(HourlyForecastTableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        
        scrolView.addSubview(labelCityName)
        scrolView.addSubview(labelDescription)
        scrolView.addSubview(labelTemperature)
        scrolView.addSubview(labelDay)
        scrolView.addSubview(labelTemperatureHighest)
        scrolView.addSubview(labelTemperatureLowest)
        scrolView.addSubview(viewSeparator1)
        scrolView.addSubview(collectionViewDailyForecast)
        scrolView.addSubview(viewSeparator2)
        scrolView.addSubview(tableViewFutureDays)
        
        view.addSubview(scrolView)
    }
    
    private func _setViewConstraints(){
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            scrolView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            scrolView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        } else {
            scrolView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            scrolView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        }
        
        scrolView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrolView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
//        scrolView.bottomAnchor.constraint(equalTo: tableViewFutureDays.bottomAnchor).isActive = true
        
        labelCityName.translatesAutoresizingMaskIntoConstraints = false
        labelCityName.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 16).isActive = true
        labelCityName.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: -16).isActive = true
        labelCityName.topAnchor.constraint(equalTo: scrolView.topAnchor, constant: 16).isActive = true
        
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 16).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: -16).isActive = true
        labelDescription.topAnchor.constraint(equalTo: labelCityName.bottomAnchor, constant: 8).isActive = true
        
        labelTemperature.translatesAutoresizingMaskIntoConstraints = false
        labelTemperature.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 8).isActive = true
        labelTemperature.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 16).isActive = true
        labelTemperature.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: -16).isActive = true
        
        labelDay.translatesAutoresizingMaskIntoConstraints = false
        labelDay.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 16).isActive = true
        labelDay.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: -16).isActive = true
        labelDay.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: 16).isActive = true
        
        labelTemperatureLowest.translatesAutoresizingMaskIntoConstraints = false
        labelTemperatureLowest.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: -16).isActive = true
        labelTemperatureLowest.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: 16).isActive = true
        
        labelTemperatureHighest.translatesAutoresizingMaskIntoConstraints = false
        labelTemperatureHighest.trailingAnchor.constraint(equalTo: labelTemperatureLowest.leadingAnchor, constant: -16).isActive = true
        labelTemperatureHighest.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: 16).isActive = true

        viewSeparator1.translatesAutoresizingMaskIntoConstraints = false
        viewSeparator1.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 0).isActive = true
        viewSeparator1.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: 0).isActive = true
        viewSeparator1.topAnchor.constraint(equalTo: labelDay.bottomAnchor, constant: 8).isActive = true
        viewSeparator1.heightAnchor.constraint(equalToConstant:1).isActive = true
        
        collectionViewDailyForecast.translatesAutoresizingMaskIntoConstraints = false
        collectionViewDailyForecast.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 0).isActive = true
        collectionViewDailyForecast.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: 0).isActive = true
        collectionViewDailyForecast.topAnchor.constraint(equalTo: viewSeparator1.bottomAnchor, constant: 16).isActive = true
        collectionViewDailyForecast.widthAnchor.constraint(equalTo: scrolView.widthAnchor, constant:0).isActive = true
        collectionViewDailyForecast.heightAnchor.constraint(equalToConstant:86).isActive = true
        
        viewSeparator2.translatesAutoresizingMaskIntoConstraints = false
        viewSeparator2.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 0).isActive = true
        viewSeparator2.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: 0).isActive = true
        viewSeparator2.topAnchor.constraint(equalTo: collectionViewDailyForecast.bottomAnchor, constant: 8).isActive = true
        viewSeparator2.heightAnchor.constraint(equalToConstant:1).isActive = true
        
        tableViewFutureDays.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            tableViewFutureDays.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            tableViewFutureDays.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        } else {
            tableViewFutureDays.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            tableViewFutureDays.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        }
        tableViewFutureDays.topAnchor.constraint(equalTo: viewSeparator2.bottomAnchor, constant: 8).isActive = true
        tableViewFutureDays.bottomAnchor.constraint(equalTo: scrolView.bottomAnchor, constant: 0).isActive = true
        tableViewFutureDays.widthAnchor.constraint(equalTo: scrolView.widthAnchor, constant:0).isActive = true
        constraintTableViewheight = tableViewFutureDays.heightAnchor.constraint(equalToConstant: 0)
        constraintTableViewheight.isActive = true
        
    }
    private func _updateComponentValues(){
        labelCityName.text = viewModel.weather.city.name
        labelDescription.text = viewModel.weather.forecast.first!.weather.first!.description.capitalized
        labelTemperature.text = "\(Int(viewModel.weather.forecast.first!.temperature))°F"
        self.dateFormatter.dateFormat = "EEEE"
        let dayName = dateFormatter.string(from: viewModel.weather.forecast.first!.dateTime)
        labelDay.text = "\(dayName) TODAY".uppercased()
        labelTemperatureHighest.text = "\(Int(viewModel.weather.forecast.first!.tempMax))"
        labelTemperatureLowest.text = "\(Int(viewModel.weather.forecast.first!.tempMin))"
        collectionViewDailyForecast.delegate = self
        collectionViewDailyForecast.dataSource = self
        collectionViewDailyForecast.reloadData()
        tableViewFutureDays.delegate = self
        tableViewFutureDays.dataSource = self
        tableViewFutureDays.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        constraintTableViewheight.constant = tableViewFutureDays.contentSize.height
    }
}


extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8 // 24 / 3 = 8 segments
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewDailyForecast.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath) as! TodayCollectionViewCell
        let forecast = viewModel.weather.forecast[indexPath.row]
        self.dateFormatter.dateFormat = "ha"
        
        dateFormatter.string(from: forecast.dateTime)
        
        cell.labelHour.text = dateFormatter.string(from: forecast.dateTime)
        cell.labelTemperature.text = "\(Int(forecast.temperature))°"
        guard let stringIcon = forecast.weather.first?.icon else {return UICollectionViewCell()}
        viewModel.fetchWeatherImage(imageString: stringIcon) { (imageData) in
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.imageViewWeather.image = image!
            }
        }
        
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFutureDays.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath) as! HourlyForecastTableViewCell
        let day = viewModel.days[indexPath.row ] // + 8 is the next day
        
        cell.labelDay.text = dateFormatter.string(from: day.forecast.dateTime)
        cell.labelDescription.text =  day.forecast.weather.first!.description
        cell.labelTemperature.text = "\(Int(day.forecast.temperature))°"
        
        guard let stringIcon = day.forecast.weather.first?.icon else {return UITableViewCell()}
        viewModel.fetchWeatherImage(imageString: stringIcon) { (imageData) in
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.imageViewWeather.image = image!
            }
        }
        
        let details = "Pressure: \(day.forecast.pressure)hpa, Humidity: \(day.forecast.humidity)%, Wind: \(day.forecast.wind.speed)m/s"
        cell.labelDetails.text = details
        
        return cell
    }
}
