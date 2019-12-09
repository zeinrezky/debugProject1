//
//  AppColor.swift
//  My Way
//
//  Created by zein rezky chandra on 09/10/18.
//  Copyright © 2018 Zein. All rights reserved.
//

import UIKit

class AppColor{
    
    func save(rgb: (CGFloat, CGFloat, CGFloat)) -> (Void) {
        UserDefaults.standard.set(rgb.0, forKey: "Red")
        UserDefaults.standard.set(rgb.1, forKey: "Green")
        UserDefaults.standard.set(rgb.2, forKey: "Blue")
    }
    
    func fetch() -> (CGFloat, CGFloat, CGFloat){
        let red = CGFloat(UserDefaults.standard.float(forKey: "Red"))
        let green = CGFloat(UserDefaults.standard.float(forKey: "Green"))
        let blue = CGFloat(UserDefaults.standard.float(forKey: "Blue"))
        
        return (red, green, blue)
    }
    
}
