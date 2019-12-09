//
//  HomeViewBuilder.swift
//  My Way
//
//  Created by zein rezky chandra on 08/10/18.
//  Copyright © 2018 Zein. All rights reserved.
//

import UIKit

protocol HomeView: class {
    func loadCurrentContext(rgb: (CGFloat, CGFloat, CGFloat)) -> (Void)
}

protocol HomeUseCase: class {
    func loadCurrentContext() -> (CGFloat, CGFloat, CGFloat)
    func saveCurrentContetx(rgb: (CGFloat, CGFloat, CGFloat)) -> ()
}

class HomeInteractor: HomeUseCase {
    var appColor: AppColor?
    init(del: AppColor = AppColor()) {
        // FIXME: Replace with something
    }
    
    func loadCurrentContext() -> (CGFloat, CGFloat, CGFloat) {
        let currentColor = appColor?.fetch()
        return currentColor!
    }
    
    func saveCurrentContetx(rgb: (CGFloat, CGFloat, CGFloat)) -> (Void) {
        appColor?.save(rgb: rgb)
    }
}

protocol HomeViewWireframe: class {
    var viewController: UIViewController? { get }
}

class HomeViewRouter: HomeViewWireframe  {
    var viewController: UIViewController?
}

protocol HomeViewPresentation: class {
    var view: HomeView? { get }
    var router: HomeViewWireframe? { get }
    var interactor: HomeUseCase? { get }
    
    func onLoadCurrentColor() -> ()
    func onValueChange(rgb: (CGFloat, CGFloat, CGFloat)) -> ()
}

class HomeViewPresenter: HomeViewPresentation {
    weak var view: HomeView?
    var router: HomeViewWireframe?
    var interactor: HomeUseCase?
    
    func onLoadCurrentColor() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            
            let currentColor = self.interactor?.loadCurrentContext()
            
            DispatchQueue.main.async {
                self.view?.loadCurrentContext(rgb: currentColor!)
            }
        }
    }
    
    func onValueChange(rgb: (CGFloat, CGFloat, CGFloat)) -> (Void) {
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let `self` = self else { return }
            
            self.interactor?.saveCurrentContetx(rgb: rgb)

            DispatchQueue.main.async {
                
            }
        }
    }
}

class HomeViewBuilder {
    static func assembleModule() -> UIViewController? {
        // FIXME: Replace with something
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController
        let presenter = HomeViewPresenter()
        let interactor = HomeInteractor()
        let router = HomeViewRouter()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
}

