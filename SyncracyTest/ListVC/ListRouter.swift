//
//  ListRouter.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import Foundation

protocol ListRoutingLogic{
    func routeToVerifyScreen()
}

class ListRouter: NSObject, ListRoutingLogic{
    //weak var viewController: VC?
    func routeToVerifyScreen() {
       // viewController?.performPushSeguefromController(identifier: "testVC")
    }
}
