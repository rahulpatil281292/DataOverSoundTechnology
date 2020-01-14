//
//  CustomerCareViewController.swift
//  MeriMaruthi
//
//  Created by ITC Infotech on 26/10/18.
//  Copyright © 2018 Rahul Patil. All rights reserved.
//

import UIKit

class CustomerCareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = false
    navigationItem.title = "Customer Care"
  }
}
