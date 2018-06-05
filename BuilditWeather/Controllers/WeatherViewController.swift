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
    var constraintTableViewheight:NSLayoutConstraint!
    
    

    let dateFormatter = DateFormatter()
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        navigationController?.isNavigationBarHidden = true
        
        viewModel = WeatherViewModel()
        self.activityIndicatorView.startAnimating()
        viewModel.forecast { [weak self] in
            self?._setViewComponents()
            self?._setViewConstraints()
            
            
            self?.dateFormatter.dateFormat = "ha"
//            for forecast in (self?.viewModel.weather.forecast)! {
//                print(forecast)
//                print("============")
//            }
            self?.activityIndicatorView.stopAnimating()
        }
    }
    
    private func _setViewComponents(){
        
        
        scrolView = UIScrollView()
        scrolView.showsHorizontalScrollIndicator = false
        
        
        viewContent = UIView()
        
        labelCityName = UILabel()
        labelCityName.text = viewModel.weather.city.name
        labelCityName.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight.light)
        labelCityName.textColor = UIColor.black
        labelCityName.textAlignment = .center
        
        labelDescription = UILabel()
        labelDescription.text = viewModel.weather.forecast.first!.weather.first!.description.capitalized
        labelDescription.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.light)
        labelDescription.textColor = UIColor.black
        labelDescription.textAlignment = .center
        
        
        labelTemperature = UILabel()
        labelTemperature.text = "\(Int(viewModel.weather.forecast.first!.temperature))°F"
        labelTemperature.font = UIFont.systemFont(ofSize: 100, weight: UIFont.Weight.light)
        labelTemperature.textColor = UIColor.black
        labelTemperature.textAlignment = .center
        
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
        labelTemperatureHighest.textAlignment = .right
        
        viewSeparator1 = UIView()
        viewSeparator1.backgroundColor = UIColor.groupTableViewBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 56, height: 86)
        collectionViewDailyForecast = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionViewDailyForecast.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: viewModel.cellIdentifier)
        collectionViewDailyForecast.backgroundColor = UIColor.white
        collectionViewDailyForecast.delegate = self
        collectionViewDailyForecast.dataSource = self
        collectionViewDailyForecast.showsHorizontalScrollIndicator = false
        viewSeparator2 = UIView()
        viewSeparator2.backgroundColor = UIColor.groupTableViewBackground
        
        tableViewFutureDays = UITableView(frame: CGRect(), style: UITableViewStyle.plain)
        tableViewFutureDays.isScrollEnabled = false
        tableViewFutureDays.estimatedRowHeight = 150
        tableViewFutureDays.rowHeight = UITableViewAutomaticDimension
        tableViewFutureDays.frame = CGRect(x: tableViewFutureDays.frame.origin.x,
                                           y: tableViewFutureDays.frame.origin.y,
                                           width: tableViewFutureDays.frame.size.width,
                                           height: tableViewFutureDays.frame.size.height+(40 * tableViewFutureDays.rowHeight))
        
        tableViewFutureDays.register(HourlyForecastTableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        tableViewFutureDays.delegate = self
        tableViewFutureDays.dataSource = self
        
//        viewContent.addSubview(labelCityName)
//        viewContent.addSubview(labelDescription)
//        viewContent.addSubview(labelTemperature)
//        viewContent.addSubview(labelDay)
//        viewContent.addSubview(labelTemperatureHighest)
//        viewContent.addSubview(labelTemperatureLowest)
//        viewContent.addSubview(viewSeparator1)
//        viewContent.addSubview(collectionViewDailyForecast)
//        viewContent.addSubview(viewSeparator2)
//        viewContent.addSubview(tableViewFutureDays)
        
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
        
        
        
//        scrolView.addSubview(viewContent)
        view.addSubview(scrolView)
        
    }
    
    private func _setViewConstraints(){
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        scrolView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//        scrolView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        scrolView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        scrolView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrolView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrolView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
//        viewContent.translatesAutoresizingMaskIntoConstraints = false
//        viewContent.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 0).isActive = true
//        viewContent.trailingAnchor.constraint(equalTo: scrolView.trailingAnchor, constant: 0).isActive = true
//        viewContent.topAnchor.constraint(equalTo: scrolView.topAnchor, constant: 0).isActive = true
//        viewContent.bottomAnchor.constraint(equalTo: scrolView.bottomAnchor, constant: 0).isActive = true
//        viewContent.heightAnchor.constraint(equalToConstant: 2200).isActive = true
//        viewContent.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
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
//        labelTemperatureHighest.leadingAnchor.constraint(equalTo: scrolView.leadingAnchor, constant: 16).isActive = true
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
        tableViewFutureDays.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableViewFutureDays.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableViewFutureDays.topAnchor.constraint(equalTo: viewSeparator2.bottomAnchor, constant: 8).isActive = true
        tableViewFutureDays.bottomAnchor.constraint(equalTo: scrolView.bottomAnchor, constant: 0).isActive = true
        tableViewFutureDays.widthAnchor.constraint(equalTo: scrolView.widthAnchor, constant:0).isActive = true
        constraintTableViewheight = tableViewFutureDays.heightAnchor.constraint(greaterThanOrEqualToConstant: 2000)
        constraintTableViewheight.isActive = true
        
        
    }
    
}


extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewDailyForecast.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath) as! TodayCollectionViewCell
        let forecast = viewModel.weather.forecast[indexPath.row]
        
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(viewModel.weather.forecast.first!.dateTime)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weather.forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFutureDays.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath) as! HourlyForecastTableViewCell
        let forecast = viewModel.weather.forecast[indexPath.row]
        
        
        
        cell.labelHour.text = dateFormatter.string(from: forecast.dateTime)
        cell.labelDescription.text =  forecast.weather.first!.description
        cell.labelTemperature.text = "\(Int(forecast.temperature))°"
        
        guard let stringIcon = forecast.weather.first?.icon else {return UITableViewCell()}
        viewModel.fetchWeatherImage(imageString: stringIcon) { (imageData) in
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.imageViewWeather.image = image!
            }
        }
        
        let details = "Pressure: \(forecast.pressure)hpa, Humidity: \(forecast.humidity)%, Wind: \(forecast.wind.speed)m/s"
        cell.labelDetails.text = details
        
        return cell
    }
    
}
extension UIScrollView {
    func resizeSroll(){
        print("Called")
        var contentRect = CGRect.zero
        for view in self.subviews {
            print("View \(view)")
            contentRect = contentRect.union(view.frame)
        }
        self.contentSize = contentRect.size
    }
}
