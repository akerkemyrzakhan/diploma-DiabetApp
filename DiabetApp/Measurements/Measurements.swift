//
//  Measurement.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 09.04.2021.
//

import Foundation
import UIKit

class Measurements{
    var sugarVr: String?
    var foodVr:String?
    var insulinShVr:String?
    var insulinLnVr:String?
    var commentVr:String?
    var strDate:String?
    
    init(_ sugarVr:String, _ foodVr:String, _ insulinShVr:String, _ insulinLnVr:String, _ commentVr:String, _ strDate:String) {
        self.sugarVr = sugarVr
        self.foodVr = foodVr
        self.insulinShVr = insulinShVr
        self.insulinLnVr = insulinLnVr
        self.commentVr = commentVr
        self.strDate = strDate
    }
}
