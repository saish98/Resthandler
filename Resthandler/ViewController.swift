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
//        makeAPIcall()
        makePostApiCall()
//        readJson()
    }
    
    func makeAPIcall() {

        apiLogProvider.request(.getArticles) { result in
            
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
    
    func makePostApiCall() {
        
        apiLogProvider.request(.create(name:"Sai", job:"Developer")) { result in
            
            switch result {
            case .success(let response):
                do {
                    let repos = try response.map(to: User.self)
                    self.textView.text = repos.debugDescription
                } catch let error {
                    print("There was something wrong with the request! Error: \(error)")
                }
               
            case .failure(let error):
                print("Failure:\(error)")
            }
        }
    }
    
    func readJson() {
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    print(jsonResult)
                }
            } catch {
                // handle error
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

