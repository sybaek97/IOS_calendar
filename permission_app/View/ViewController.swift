//
//  ViewController.swift
//  permission_app
//
//  Created by 백승용 on 8/13/24.
//

import UIKit


class ViewController: UIViewController {
    
    let deviceModel = UIDevice.current.model
    let systemVersion = UIDevice.current.systemVersion
    let timeZone = TimeZone.current
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let calendarManager = CalendarManager()
        calendarManager.requestRemindersAccess()
    }


}

