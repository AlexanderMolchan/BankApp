//
//  TabBarController.swift
//  BankApp
//
//  Created by Александр Молчан on 17.01.23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateTabBar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item),
              tabBar.subviews.count > index + 1,
              let imageView = tabBar.subviews[index + 1].subviews.compactMap({ $0 as? UIImageView }).first else { return }
        imageView.layer.add(bounceAnimation, forKey: nil)
        hapticAlternative()
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.3, 0.9, 1.0]
        bounceAnimation.duration = 0.3
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    private func hapticAlternative() {
        let generator = UIImpactFeedbackGenerator()
        generator.impactOccurred()
    }

    private func configurateTabBar() {
        let mapController = UINavigationController(rootViewController: MapController(nibName: String(describing: MapController.self), bundle: nil))
        let settingsController = UINavigationController(rootViewController: SettingsController(nibName: String(describing: SettingsController.self), bundle: nil))
        
        viewControllers = [mapController, settingsController]
        tabBar.tintColor = .systemCyan
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .white
        tabBar.alpha = 0.9
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        
        mapController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map.circle.fill"), tag: 0)
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.2"), tag: 1)
    }
    
}