//
//  HomeViewController.swift
//  DecoderPractical
//
//  Created by Muvi on 09/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var blurView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIButton.appearance().dropShadow(opacity: 1, radius: 4)
    }
   
    @IBAction func buttonTouched(_ sender: UIButton) {
    
        if sender.tag == 1 {
            let storyboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DevChatVC")
            self.navigationController?.pushViewController(storyboardVC, animated: true)
        }
        else if sender.tag == 4 {
            let storyboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CodesVC")
            self.navigationController?.pushViewController(storyboardVC, animated: true)
        }
    }

}
