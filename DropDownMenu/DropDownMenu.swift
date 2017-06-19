//
//  DropDownMenu.swift
//  Lambda
//
//  Created by Dmitry Pimenov on 6/18/17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

@objc public protocol DropDownMenuDelegate {
    func menuItemSelected(sender: UIButton)
}

open class DropDownMenu: UIView {
    let buttonHeight: CGFloat = 40
    let offSet: CGFloat = 2
    
    var primaryButton: UIButton?
    var lastSelectedIndex: Int = 0
    var delegate: DropDownMenuDelegate?
    var data: [String] = []
    var menuView: UIScrollView?
    var parentView: UIView?
    var tapRecognizer: UITapGestureRecognizer?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, data: [String], parentView: UIView){
        super.init(frame: frame)
        self.data = data
        self.parentView = parentView
        setUp()
    }
    
    func setUp(){
        self.primaryButton = UIButton(frame: self.bounds)
        self.primaryButton?.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        self.primaryButton!.setTitle(self.data[self.lastSelectedIndex], for: .normal)
        self.styleButton(button: self.primaryButton!)
        self.addSubview(self.primaryButton!)
        
        self.tapRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(_:)))
        self.tapRecognizer!.numberOfTapsRequired = 1
        
        let heightApproximation = Double(CGFloat((offSet+buttonHeight)*CGFloat(data.count-1)))
        var heightProvided = heightApproximation
        if (heightApproximation > Double(self.parentView!.frame.height/2)){
            heightProvided = Double(self.parentView!.frame.height/1.3)
        }
        self.menuView = UIScrollView(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y+self.frame.size.height
            , width: self.frame.size.width, height: CGFloat(heightProvided)))
        self.menuView?.contentSize = CGSize(width: self.frame.size.width, height: CGFloat(heightApproximation))
        self.backgroundColor = UIColor.clear
        self.menuView?.backgroundColor = UIColor.clear
        var count = 0
        if (data.count > 0){
            for i in 0 ..< data.count {
                if (i != self.lastSelectedIndex){
                    addButton(string: data[i], index: i, shift:count)
                    count+=1
                }
            }
        }
    }
    
    func addButton(string: String, index: Int, shift: Int){
        let currentX: CGFloat = 0.0
        let currentY: CGFloat = (buttonHeight+offSet)*CGFloat(shift)+offSet
        let width = self.frame.width
        let button = UIButton(frame: CGRect(x: currentX, y: currentY, width: width, height: buttonHeight))
        self.styleButton(button: button)
        button.setTitle(string, for: .normal)
        button.tag = index
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        self.menuView?.addSubview(button)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        if(sender.state == .recognized)
        {
            let point = sender.location(in: parentView)
            if (!self.frame.contains(point)){
                hideMenu()
            }
        }
    }
    
    func buttonPressed(_ sender: UIButton) {
        self.hideMenu()
        let copy = self.lastSelectedIndex
        self.lastSelectedIndex = sender.tag
        sender.tag = copy
        sender.setTitle(self.data[sender.tag], for: .normal)
        self.primaryButton?.setTitle(self.data[self.lastSelectedIndex], for: .normal)
        //swap
        delegate?.menuItemSelected(sender: sender)
    }
    
    func hideMenu(){
        self.menuView?.removeFromSuperview()
        if (self.parentView?.gestureRecognizers?.contains(self.tapRecognizer!))! {
            self.parentView?.removeGestureRecognizer(self.tapRecognizer!)
        }
    }
    
    func showMenu(){
        self.parentView?.addSubview(self.menuView!)
        self.parentView?.addGestureRecognizer(self.tapRecognizer!)
    }
    
    func styleButton(button: UIButton){
        button.titleLabel?.font = UIFont(name: "Georgia", size: 17)
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.textColor = UIColor.white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 5.0
    }
}
