//
//  ViewController.swift
//  QRcode Scanner
//
//  Created by Abhay Sidhwani on 28/12/17.
//  Copyright © 2017 Abhay Sidhwani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func generateButton(_ sender: UIButton) {
        let generateviewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "generateViewController") as! generateViewController
        self.present(generateviewcontroller, animated: true)
    }
    
    
    @IBAction func readQR(_ sender: UIButton) {
        let readviewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "readOnlyViewController") as! readOnlyViewController
        self.present(readviewcontroller, animated: true)
    }
    

}

