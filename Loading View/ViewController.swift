//
//  ViewController.swift
//  Loading View
//
//  Created by Johnny Wang on 2017/12/29.
//  Copyright © 2017年 Johnny Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let loadViewController = MLLoadingViewController(text: "Just Wait...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func activeLoading() {
        present(loadViewController, animated: true)
        Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(stopLoadingView), userInfo: nil, repeats: false)
    }
    
    @objc private func stopLoadingView() {
        loadViewController.dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

