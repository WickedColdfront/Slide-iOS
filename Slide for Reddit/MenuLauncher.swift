//
//  MenuLauncher.swift
//  Slide for Reddit
//
//  Created by WickedColdfront on 8/7/17.
//  Copyright © 2017 Haptic Apps. All rights reserved.
//
// https://www.youtube.com/watch?v=2kwCfFG5fDA
// https://www.youtube.com/watch?v=PNmuTTd5zWc
// https://www.youtube.com/watch?v=DYsfAD01fYk

import UIKit

class MenuOption: NSObject {
    let name: String
    let imageName: String
    let action: () -> ()
    
    init(name: String, imageName: String, action: @escaping () -> ()) {
        self.name = name
        self.imageName = imageName
        self.action = action
    }
}

class MenuLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let blackView = UIView()
    
    var selectedOption : MenuOption?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 40
    
    var menuOptions: [MenuOption] = {
        return [
            MenuOption(name: "Menu Option 1", imageName: "folder", action: {print("1")}),
            MenuOption(name: "Menu Option 2", imageName: "up", action: {print("2")}),
            MenuOption(name: "Menu Option 3", imageName: "down", action: {print("3")}),
            MenuOption(name: "Menu Option 4", imageName: "subbed", action: {print("4")}),
            MenuOption(name: "Menu Option 5", imageName: "subs", action: {print("5")}),
            MenuOption(name: "Menu Option 6", imageName: "save", action: {print("6")})
            ]
    }()
    
    
    func dismissMenu(menuOption: MenuOption) {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.blackView.alpha = 0
                    if let window = UIApplication.shared.keyWindow {
                        self.collectionView.frame = CGRect(x: 0, y: window.frame.height,width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                    }
                }, completion: {
                    (value: Bool) in
                    if menuOption.name != "" {
                        menuOption.action()
                    }
                })
    }
    
    func showMenu(){
        
        if let window = UIApplication.shared.keyWindow {
            
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
            window.addSubview(blackView)
            
            window.addSubview(collectionView)
            
            var cvHeight: CGFloat = CGFloat(menuOptions.count) * cellHeight
            
            if cvHeight > (window.frame.height * CGFloat(0.75)) { //hack to make sure menu isn't larger than screen
                cvHeight = window.frame.height * CGFloat(0.75)
            }

            let cvTop = window.frame.height - cvHeight
            collectionView.frame = CGRect(x: 0, y: window.frame.height,width: window.frame.width,height: cvHeight)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: cvTop,width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
            

        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let menuOption = menuOptions[indexPath.item]
        cell.menuOption = menuOption
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuOption = menuOptions[indexPath.item]
        dismissMenu(menuOption: menuOption)
    }
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)

    }
}
