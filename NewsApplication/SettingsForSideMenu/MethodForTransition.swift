//
//  MethodForTransition.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/10/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

class Properties {
    static let shared = Properties()
    let transtion = TransitionClass()
    var topView: UIView?
}

class MethodsForSideMenu {

    func transitionToNew(_ menuType: MenuType, uiView: UIViewController) {
        Properties.shared.topView?.removeFromSuperview()
        switch menuType {
        case .news:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NewsFeedController")
//            uiView.dismiss(animated: true, completion: nil) //
            uiView.view.addSubview(vc.view)
            Properties.shared.topView = vc.view
            uiView.addChild(vc)
        case .links:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SavedSourcesController")
//            uiView.dismiss(animated: true, completion: nil)//
//            if !uiView.children.isEmpty {
//                if uiView.children[0] == self {
//                    print("win")
//                } else {
//                    print(uiView.children[0])
//                }
//            }
            
            uiView.view.addSubview(vc.view)
            Properties.shared.topView = vc.view
            uiView.addChild(vc)
            
        case .weather:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WeatherViewController")
            uiView.view.addSubview(vc.view)
            Properties.shared.topView = vc.view
            uiView.addChild(vc)
        case .profile:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProfilePageViewController")
            uiView.view.addSubview(vc.view)
            Properties.shared.topView = vc.view
            uiView.addChild(vc)
        case .logout:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
            uiView.dismiss(animated: true, completion: nil)
            uiView.present(vc, animated: true, completion: nil)
//            uiView.view.addSubview(vc.view)
//            Properties.shared.topView = vc.view
//            uiView.addChild(vc)
        }
    }

func openSideMenu(uiview: UIViewController) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let vc = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {return}
    vc.didTapMenuType = { menuType in
        let sideMenuMethods = MethodsForSideMenu()
        sideMenuMethods.transitionToNew(menuType, uiView: uiview)
    }
    vc.modalPresentationStyle = .overCurrentContext
    vc.transitioningDelegate = uiview as? UIViewControllerTransitioningDelegate
    uiview.present(vc, animated: true, completion: nil)
}
}
