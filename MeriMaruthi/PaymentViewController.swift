//
//  PaymentViewController.swift
//  MeriMaruthi
//
//  Created by ITC Infotech on 26/10/18.
//  Copyright © 2018 Rahul Patil. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    //chirpPaymetIdentifier = "-"
    navigationController?.navigationBar.isHidden = false
    navigationItem.title = "Transactions"
  }
  
  @IBAction func payBtnPressed_TouchUpInside(_ sender : UIButton ) {
    chirpPaymetIdentifier = "chirp"
    let vc = UIAlertController(title: "", message: "Thank you for payment", preferredStyle: .alert)
    vc.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(vc, animated: true, completion: nil)
  }
}
