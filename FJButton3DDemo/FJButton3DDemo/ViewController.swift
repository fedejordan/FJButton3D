//
//  ViewController.swift
//  FJButton3DDemo
//
//  Created by Federico Jordán on 21/4/18.
//  Copyright © 2018 Federico Jordán. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FJButton3DDelegate {

    @IBOutlet private weak var button3D: FJButton3D!
    @IBOutlet private weak var toggleButton3D: FJButton3D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        toggleButton3D.style = .pressed
        button3D.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didTap(onButton3D button3d: FJButton3D) {
        toggleButton3D.pressed = false
    }

}

