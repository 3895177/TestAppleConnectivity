//
//  InterfaceController.swift
//  WatchConnectivity01 WatchKit Extension
//
//  Created by GZTuYoo on 16/5/5.
//  Copyright © 2016年 GZTuyoo. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBOutlet var lab: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        //1.激活session
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    @IBAction func sendAction() {
        //检查是否可达
        if WCSession.defaultSession().reachable {
            let msg = ["msg":"你好iPhone，我是watch。"]
            WCSession.defaultSession().sendMessage(msg, replyHandler: {(result:[String:AnyObject]) -> Void in
                self.lab.setText(result.description)
                }, errorHandler: {(error:NSError) -> Void in
                    print(error)
                })
        }
        
    }
    
    @IBAction func sendUserMessage() {
        if WCSession.defaultSession().reachable {
            WCSession.defaultSession().transferUserInfo(["msg":"真是一个UserInfo消息","title":"标题"])
        }
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}


extension InterfaceController:WCSessionDelegate {
    func session(session: WCSession, didFinishUserInfoTransfer userInfoTransfer: WCSessionUserInfoTransfer, error: NSError?) {
        print("ipad didFinishUserInfoTransfer")
        
        print(userInfoTransfer)
        if error != nil {
            print(error)
        }
    }
}