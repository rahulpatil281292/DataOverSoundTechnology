
//
//  HomeViewController.swift
//  MeriMaruthi
//
//  Created by ITC Infotech on 26/10/18.
//  Copyright © 2018 Rahul Patil. All rights reserved.
//

import UIKit

// MARK: File Constants
private let APP_KEY = "DMukf4wXgq7ZEqK0f8kCSmY4r"
private let SECRET_KEY = "sC68ChaSaD3r6S6BWaXxIey4JYWd8ksuhZNyKcx5e0OFy1TrJk"
var chirpPaymetIdentifier = "-"
var offerNotificationIdentifier = "-"

class HomeViewController: UIViewController {

  // MARK: UI Elements
  @IBOutlet weak var offerNotificationImageView : UIImageView!
  @IBOutlet weak var transactionImageView : UIImageView!
  @IBOutlet weak var addImageView : UIImageView!
  @IBOutlet weak var chirpImageView : UIImageView!
  @IBOutlet weak var chirpButton : UIButton!
  @IBOutlet weak var offerPopUpImage : UIImageView!
  
  // MARK: Proerties
  // Segue identifiers
  let olderOfferSegue = "olderOfferViewController"
  let newOfferSegue = "newOfferViewController"
  let paymentSegue = "trasactionViewController"
  let paymentOldSegue = "paymentOlderViewController"
  let nearMaruthiSegue = "nearMaruthiMeViewController"
  let bookCarServiceSegue = "bookCarServiceViewController"
  let bookTestRideSegue = "bookTestRideViewController"
  let customerCareSegue = "customerCareViewController"
  
  // notification identifier
  var offerNotificationId = "-"
  var transactionNotificationId = "-"
  
  // Chirp Identifier

  
  // chirp connect
  var connect : ChirpConnect!
  
  // frame
  let frameOrg = CGRect(x: 10, y: 403, width: 355, height: 264)
  let frameUpt = CGRect(x: 10, y: 567, width: 355, height: 264)
  
  // MARK: UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      chirpSDKSetUp()
      setUp()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.backgroundColor = .green
    navigationController?.navigationBar.tintColor = .white
    setUp()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if chirpPaymetIdentifier == "chirp" {
      chirpSDKSetUp()
    }
  }
  
  // MARK: Commons
  private func setUp() {
    offerPopUpImage.isHidden = true
    if chirpPaymetIdentifier == "-" {
      chirpImageView.isHidden = true
      addImageView.isHidden = false
      chirpButton.isEnabled = false
      addImageView.frame = frameOrg
    } else if chirpPaymetIdentifier == "chirp" {
      chirpImageView.isHidden = false
      addImageView.isHidden = false
      chirpButton.isEnabled = true
      addImageView.frame = frameUpt
    }
    
    if chirpPaymetIdentifier == "-" {
      transactionImageView.image = UIImage()
    } else if chirpPaymetIdentifier == "chirp" {
      transactionImageView.image = UIImage()
      connect.stop()
    } else {
      transactionImageView.image = UIImage(named: "Group18")
    }
    
    if offerNotificationIdentifier == "-" {
      offerNotificationImageView.image = UIImage()
    } else {
      offerNotificationImageView.image = UIImage(named: "Group18")
    }
  }
  
  private func setUpAfterChirpReceive() {
    connect.stop()
    offerPopUpImage.isHidden = false
    showView(objView: offerPopUpImage)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 , execute: { [weak self] in
      self?.offerNotificationImageView.image = UIImage(named: "Group18")
      self?.offerNotificationId = "Group18"
      offerNotificationIdentifier = "off"
      self?.transactionImageView.image = UIImage(named: "Group18")
      self?.transactionNotificationId = "Group18"
      chirpPaymetIdentifier = "chi"
    })
  }
  
  func showView(objView:UIView){
    objView.alpha = 0.0
    UIView.animate(withDuration: 1.0, animations: {
      objView.alpha = 0.0
    }, completion: { (completeFadein: Bool) -> Void in
      objView.alpha = 1.0
      let transition = CATransition()
      transition.duration = 2.0
      transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
      transition.type = kCATransitionFade
      objView.layer.add(transition, forKey: nil)
    })
  }
  
  func HideView(objView:UIView){
    UIView.animate(withDuration: 0.5, animations: {
      objView.alpha = 1.0
    }, completion: { [weak self](completeFadein: Bool) -> Void in
      objView.alpha = 0.0
      let transition = CATransition()
      transition.duration = 2.0
      transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
      transition.type = kCATransitionFade
      objView.layer.add(transition, forKey: nil)
      self?.offerPopUpImage.isHidden = true
    })
  }
  
  // MARK: IBButton actions
  @IBAction func nearMeMaruthiBtnPressed_TouchUpInside(_ sender : UIButton ){
    performSegue(withIdentifier: nearMaruthiSegue, sender: self)
  }
  
  @IBAction func bookCarServiceBtnPressed_TouchUpInside(_ sender : UIButton ) {
    performSegue(withIdentifier: bookCarServiceSegue, sender: self)
  }
  
  @IBAction func bookTestRideBtnPressed_TouchUpInside(_ sender : UIButton ) {
    performSegue(withIdentifier: bookTestRideSegue, sender: self)
  }
  
  @IBAction func customerCareBtnPressed_TouchUpInside(_ sender : UIButton ){
    performSegue(withIdentifier: customerCareSegue, sender: self)
  }
  
  @IBAction func exclusiveOfferBtnPressed_TouchUpInside(_ sender : UIButton ) {
    if offerNotificationId == "Group18" {
      performSegue(withIdentifier: newOfferSegue, sender: self)
    } else {
      performSegue(withIdentifier: olderOfferSegue, sender: self)
    }
  }
  
  @IBAction func transactionBtnPressed_TouchUpInside(_ sender : UIButton ) {
    if transactionNotificationId == "Group18" {
      performSegue(withIdentifier: paymentSegue, sender: self)
    } else {
      performSegue(withIdentifier: paymentOldSegue, sender: self)
    }
  }
  
  @IBAction func chirpCodeBtnPressed_TouchUpInside(_ sender : UIButton ) {
    guard let dataString = sendingDataString() else {
      return
    }
    guard let payloadData = dataString.data(using: String.Encoding.utf8) else {
      return
    }
    print(payloadData)
    connect.send(payloadData)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
      self?.HideView(objView: (self?.chirpImageView)!)
      self?.addImageView.isHidden = false
      self?.chirpButton.isEnabled = false
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {[weak self] in
      self?.addImageView.frame = (self?.frameOrg)!
      self?.showView(objView: (self?.addImageView)!)
    }
  }
  
  @IBAction func doneBtnOfferPressed(_ sender : UIButton ) {
    HideView(objView: offerPopUpImage)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination
    switch vc {
    case is NearMaruthiMeViewController:
      navigationController?.navigationBar.barTintColor = UIColor(red: 233/255, green: 0/255, blue: 82/255, alpha: 1.0)
    case is BookCarServiceViewController:
      navigationController?.navigationBar.barTintColor = UIColor(red: 38/255, green: 168/255, blue: 223/255, alpha: 1.0)
    case is BookTestRideViewController:
      navigationController?.navigationBar.barTintColor = UIColor(red: 150/255, green: 2/255, blue: 236/255, alpha: 1.0)
    case is CustomerCareViewController:
      navigationController?.navigationBar.barTintColor = UIColor(red: 234/255, green: 149/255, blue: 12/255, alpha: 1.0)
    case is OlderOfferViewController:
      navigationController?.navigationBar.barTintColor = .green
    case is NewOfferViewController:
      navigationController?.navigationBar.barTintColor = .green
    case is PaymentOldViewController:
      navigationController?.navigationBar.barTintColor = .red
    case is PaymentViewController:
      navigationController?.navigationBar.barTintColor = .red
    default:
      print("ERROR")
    }
    let backItem = UIBarButtonItem()
    backItem.title = "Home"
    navigationItem.backBarButtonItem = backItem
  }
}

// MARK: Extension
// MARK: ChirpConnect SDK
extension HomeViewController {
  // ChirpConnect SDK setup and Athorization
  private func chirpSDKSetUp() {
    connect  = ChirpConnect(appKey: APP_KEY, andSecret: SECRET_KEY)!
    print("Version of Chrip SDK : \(connect.version)")
    guard let confiStringUtlrasonic = confiStringFromFileUltrasonic() else {
      return
    }
    guard let confiStringStandard = confiStringFromFileForStandard() else {
      return
    }
    if chirpPaymetIdentifier == "chirp" {
      let error = connect.setConfig(confiStringStandard)
      if (!(error != nil)) {
        startAnStopSDK()
      } else {
        print("EROOR in starting SDK.")
      }
    } else {
      let error = connect.setConfig(confiStringUtlrasonic)
      if (!(error != nil)) {
        startAnStopSDK()
      } else {
        print("EROOR in starting SDK.")
      }
    }
    
  }
  
  private func startReceivingChirp() {
    let err = connect.receivingBlock
    if (!(err != nil)) {
      connect.receivedBlock = {
        (data : Data?, channel: UInt?) -> () in
        if let data = data {
          self.setUpAfterChirpReceive()
          if let travelCode = String(data: data, encoding: .ascii) {
            if travelCode == "11" {
             // self.setUpAfterChirpReceive()
            }
          }
          return
        }
      }
    }
  }
  
  private func startAnStopSDK() {
    if connect.state == CHIRP_CONNECT_STATE_STOPPED {
      let error = connect.start()
      if (!(error != nil)) {
        startReceivingChirp()
      } else {
        print("ERROR : \(String(describing: error))")
      }
    } else {
      connect.stop()
    }
  }
  
  // getting confi string from standard file
  private func confiStringFromFileUltrasonic() -> String? {
    let asset = NSDataAsset(name: "ultrasonic")
    guard let data = asset?.data else {
      return nil
    }
    let string = NSString(data: data, encoding: String.Encoding.ascii.rawValue)
    guard let confiString = string as String? else {
      return nil
    }
    return confiString
  }
  
  private func confiStringFromFileForStandard() -> String? {
    let asset = NSDataAsset(name: "standard")
    guard let data = asset?.data else {
      return nil
    }
    let string = NSString(data: data, encoding: String.Encoding.ascii.rawValue)
    guard let confiString = string as String? else {
      return nil
    }
    return confiString
  }
  
  private func sendingDataString() -> String? {
    let chirpSendingData = "11"
    return chirpSendingData
  }
}












