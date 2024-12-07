//
//  AppDelegate.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let data = Data()
        data.name = "Angela"
        data.age = 12
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("error initialising realm \(error.localizedDescription)")
        }
            
        
        return true
    }

 
}



