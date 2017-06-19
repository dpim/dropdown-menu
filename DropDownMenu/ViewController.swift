//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Dmitry Pimenov on 6/18/17.
//  Copyright © 2017 Dmitry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DropDownMenuDelegate {

    let names = ["Ada", "Brad", "Cathy", "Daniel", "Emily"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = CGRectFromString("{{50,50},{100,40}}")
        let menuView = DropDownMenu(frame: frame, data: self.names, parentView: self.view)
        menuView.delegate = self
        self.view.addSubview(menuView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //delegate
    func menuItemSelected(sender: UIButton) {
        print(sender)
        print(self.names[sender.tag])
    }
}

