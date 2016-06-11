//
//  ViewController.swift
//  ObjectToJsonDemo
//
//  Created by Madan Dale on 6/11/16.
//  Copyright © 2016 Madan Dale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        convertObjecdtToDict();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    internal func convertObjecdtToDict() {
    
        let loginDetail = LoginDetail()
        loginDetail.userName = "sachin"
        loginDetail.passWord = "password"
        loginDetail.token = "tokenId"
        
        print(" Login object to dictionary data \(loginDetail.toDictionary())")
        
        
    }
    
    
}

