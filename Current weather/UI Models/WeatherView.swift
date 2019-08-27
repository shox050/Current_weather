//
//  WeatherView.swift
//  Current weather
//
//  Created by Vladimir on 25/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var ivImage: UIImageView!
    @IBOutlet private weak var lTemperatureInfo: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(Constants.Identifiers.weatherNibNamed, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    func configure(with weatherInformation: WeatherInformation) {
        
    }
    
//    override func draw(_ rect: CGRect) {
//
//    }
}
