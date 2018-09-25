//
//  ViewController.swift
//  Resthandler
//
//  Created by Heady on 23/09/18.
//  Copyright © 2018 Heady. All rights reserved.
//
//  Thanks to: https://reqres.in, @sunshinejr, @Moya
//

import UIKit
import Moya
import Moya_ModelMapper
import Mapper

enum API {
    case createUser
    case updateUser
    case deleteUser
    case getUser
    case getUsers
    case getArticles
    
    static let type: API = .getUsers
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func ButtonAction(_ sender: Any) {
        switch API.type {
        case .createUser:
            createUser()
            
        case .updateUser:
            updateUser()
            
        case .deleteUser:
            deleteUser()
            
        case .getUser:
            getUser()
            
        case .getUsers:
            getUsers()
            
        case .getArticles:
            getArticles()
        }
    }
    
    func createUser() {
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
    
    func getUser() {
        apiLogProvider.request(.getUser(id:"2")) { result in
            
            switch result {
            case .success(let response):
                do {
                    let repos = try response.map(to: User.self, keyPath: "data")
                    self.textView.text = repos.debugDescription
                } catch let error {
                    print("There was something wrong with the request! Error: \(error)")
                }
                
            case .failure(let error):
                print("Failure:\(error)")
            }
        }
    }
    
    func getUsers() {
        apiLogProvider.request(.getUsers) { result in
            
            switch result {
            case .success(let response):
                do {
                    let repos = try response.map(to: Page.self)
                    self.textView.text = repos.debugDescription
                } catch let error {
                    print("There was something wrong with the request! Error: \(error)")
                }
                
            case .failure(let error):
                print("Failure:\(error)")
            }
        }
    }
    
    func updateUser() {
        apiLogProvider.request(.update(id:"309", name:"saish", job:"developer")) { result in
            
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
    
    
    func deleteUser() {
        //MARK: Not Working
        apiLogProvider.request(.delete(id:"309")) { result in
            
            switch result {
            case .success(let response):
                do {
                    let repos = try response.map(to: [User].self)
                    self.textView.text = repos.debugDescription
                } catch let error {
                    print("There was something wrong with the request! Error: \(error)")
                }
                
            case .failure(let error):
                print("Failure:\(error)")
            }
        }
    }
    
    func getArticles() {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

