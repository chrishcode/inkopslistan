//
//  SwipeViewController.swift
//  inkopslistan
//
//  Created by Christopher Wohlfarth on 2016-03-16.
//  Copyright © 2016 Christopher Wohlfarth. All rights reserved.
//

import UIKit
import EZSwipeController
class SwipeViewController: EZSwipeController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(netHex: 0xF8FAFF)
    }
    
    override func setupView() {
        super.setupView()
        navigationBarShouldNotExist = true
        datasource = self
    }
}


// Makes colors easier.
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

// Letter spacing
extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
        self.attributedText = attributedString
    }
}


// Creates start view
func createStartSwipeView() -> UIViewController {
    let view = UIViewController()
    view.view.backgroundColor = UIColor(netHex: 0x218380)
    
    let titleLabel = UILabel(frame: CGRectMake(0, 300, view.view.frame.size.width, 50))
    titleLabel.textAlignment = NSTextAlignment.Center
    titleLabel.addCharactersSpacing(3, text: "Inköpslistan")
    titleLabel.textColor = UIColor(netHex: 0xffffff)
    titleLabel.font = UIFont(name: "Montserrat-UltraLight", size: 30)
    view.view.addSubview(titleLabel)
    
    // Create the navigation bar
    let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, view.view.frame.size.width, 64)) // Offset by 20 pixels vertically to take the status bar into account
    
    navigationBar.backgroundColor = UIColor(netHex: 0x218380)
    navigationBar.translucent = false
    navigationBar.barTintColor = UIColor(netHex: 0x218380)
    
    
    for parent in navigationBar.subviews {
        for childView in parent.subviews {
            if(childView is UIImageView) {
                childView.removeFromSuperview()
            }
        }
    }
    
    navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Montserrat-ExtraBold", size: 26)!, NSForegroundColorAttributeName: UIColor(netHex: 0xffffff)]
    // navigationBar.delegate = self;
    
    // Create a navigation item
    let navigationItem = UINavigationItem()
    let plusButton : UIBarButtonItem = UIBarButtonItem(title: "Ny Lista", style: UIBarButtonItemStyle.Plain, target: view, action: "")
    plusButton.tintColor = UIColor(netHex: 0xffffff)
    navigationItem.rightBarButtonItem = plusButton
    
    // Assign the navigation item to the navigation bar
    navigationBar.items = [navigationItem]
    
    // Make the navigation bar a subview of the current view controller
    view.view.addSubview(navigationBar)
    
    return view
}


extension SwipeViewController: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {

        // Array with swipe views
        var views = [UIViewController]()
        
        // Create start swipe view
        let startSwipeView = createStartSwipeView()
        views.append(startSwipeView)
        
        // Array with view background colors
        let colors = [0xFFBC42, 0xD81159, 0x8F2D56, 0x218380]
        var colorCount = 0
        
        for color in colors {
            colorCount++
            let view = UIViewController()
            view.view.backgroundColor = UIColor(netHex: color)
            
            // Create the navigation bar
            let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64)) // Offset by 20 pixels vertically to take the status bar into account
            
            navigationBar.backgroundColor = UIColor(netHex: color)
            navigationBar.translucent = false
            navigationBar.barTintColor = UIColor(netHex: color)
            
            
            for parent in navigationBar.subviews {
                for childView in parent.subviews {
                    if(childView is UIImageView) {
                        childView.removeFromSuperview()
                    }
                }
            }
            
            navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Montserrat-ExtraBold", size: 26)!, NSForegroundColorAttributeName: UIColor(netHex: 0xffffff)]
            //            navigationBar.delegate = self;
            
            // Create a navigation item with a title
            let navigationItem = UINavigationItem()
            navigationItem.title = "Matlista \(colorCount)"
            
            // Assign the navigation item to the navigation bar
            navigationBar.items = [navigationItem]
            
            // Make the navigation bar a subview of the current view controller
            view.view.addSubview(navigationBar)
            
            views.append(view)
        }
        
        return views
    }
}