//
//  WeatherView.swift
//  Current weather
//
//  Created by Vladimir on 25/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lTemperatureInfo: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
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
