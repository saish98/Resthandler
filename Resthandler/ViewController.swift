//
//  ViewController.swift
//  Resthandler
//
//  Created by Heady on 23/09/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import Mapper

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func ButtonAction(_ sender: Any) {
        makeAPIcall()
    }
    
    func makeAPIcall() {

        apiLogProvider.request(.zen) { result in
            
            switch result {
            case .success(let response):
                do {
                    let repos = try response.map(to: [Article].self)
                    self.textView.text = repos.debugDescription
                } catch let error {
                    print("There was something wrong with the request! Error: \(error)")
                }
                
            case .failure(let error):
                print("Failure:\(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

