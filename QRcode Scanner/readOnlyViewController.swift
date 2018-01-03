//
//  readOnlyViewController.swift
//  QRcode Scanner
//
//  Created by Abhay Sidhwani on 29/12/17.
//  Copyright © 2017 Abhay Sidhwani. All rights reserved.
//

import UIKit

class readOnlyViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBAction func goToScan(_ sender: UIButton) {
        let scancontroller = self.storyboard?.instantiateViewController(withIdentifier: "ScanViewController") as! ScanViewController
        self.present(scancontroller, animated: true)
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
