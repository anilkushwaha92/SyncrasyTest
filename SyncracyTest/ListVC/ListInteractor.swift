//
//  ListInteractor.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import Foundation

protocol ListBusinessLogic {
    func List(request: ListModel.Process.Request, languageType : String, countryType : String, email : String)
}
class ListInteractor: ListBusinessLogic{
    var worker = ListWorker()
    var presenter : ListPresenter?
    func List(request: ListModel.Process.Request, languageType : String, countryType : String, email : String) {
        
        worker.hitMethodForGetList(email : email, languageType : languageType, countryType : countryType) { (obj) in
            
            self.presenter?.presentList(response: obj)
            
        } fail: { (message) in
            
            self.presenter?.presentList(response: ListModel.Process.Response(success: false))
        }

    }
}
