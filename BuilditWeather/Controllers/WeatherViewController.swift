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
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        viewModel = WeatherViewModel()
        viewModel.forecast()
        
    }
}

