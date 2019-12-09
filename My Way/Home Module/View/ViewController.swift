//
//  ViewController.swift
//  My Way
//
//  Created by zein rezky chandra on 08/10/18.
//  Copyright © 2018 Zein. All rights reserved.
//

import UIKit

protocol PositionValueDelegate {
    func onValueChanged() -> ()
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var sliderTop: UISlider!
    @IBOutlet weak var sliderMiddle: UISlider!
    @IBOutlet weak var sliderBottom: UISlider!
    
    var presenter: HomeViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadCurrentContext()
    }
        
    func saveCurrentContext(rgb: (CGFloat, CGFloat, CGFloat)) -> (Void){
        presenter?.onValueChange(rgb: rgb)
    }
    
    func loadCurrentContext() -> () {
        presenter?.onLoadCurrentColor()
    }
        
}

extension HomeViewController: HomeView {
    func loadCurrentContext(rgb: (CGFloat, CGFloat, CGFloat)) {
        DispatchQueue.main.async {
            self.sliderTop.value = Float(rgb.0)
            self.sliderMiddle.value = Float(rgb.1)
            self.sliderBottom.value = Float(rgb.2)
            self.myLabel.text = "RGB ( \(rgb.0), \(rgb.1), \(rgb.2) )"
        }
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async {
                self.view.backgroundColor = UIColor(red: rgb.0/255, green: rgb.1/255, blue: rgb.2/255, alpha: 1.0)
            }
        }
    }
}

extension HomeViewController: PositionValueDelegate{
    func onValueChanged() {
        let divider: Float = 1

        let x = CGFloat(round(sliderTop.value / divider) * divider)
        let y = CGFloat(round(sliderMiddle.value / divider) * divider)
        let z = CGFloat(round(sliderBottom.value / divider) * divider)

        DispatchQueue.main.async {
            self.myLabel.text = "RGB ( \(x), \(y), \(z) )"
            self.view.backgroundColor = UIColor(red: x/255, green: y/255, blue: z/255, alpha: 1.0)
        }
        saveCurrentContext(rgb: (x, y, z))
    }
}

