//
//  ListWorker.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import Foundation

class ListWorker{

    typealias responseHandler = (_ response:ListModel.Process.Response) ->()
    
    func hitMethodForGetList(email : String, languageType : String, countryType : String, success:@escaping(responseHandler), fail:@escaping(responseHandler))
        {
        //call network. 
        let obj : APIClient? = APIClient()
        obj?.getList(url: Constant.APPURL.channelList+"appname="+Constant.APP_NAME+"&email="+email+"&lang="+languageType+"&country="+countryType, completion: { (dataObj) in
           // Implement JSON decoding and parsing
            if dataObj != nil {
                do {
                    //Decode retrived data with JSONDecoder
                    let dataObj = try JSONDecoder().decode(ListResponseModel.self, from: dataObj!)
                    let resOnfo = ListModel.Process.Response(success: true, msg: "Success", list: dataObj)
                    success(resOnfo)
                } catch let jsonError {
                    print(jsonError)
                    let resOnfo = ListModel.Process.Response(success: false, msg: jsonError.localizedDescription, list: nil)
                    fail(resOnfo)
                }

            }else{
                let resOnfo = ListModel.Process.Response(success: false, msg: "Error!! Unable to parse", list: nil)
                fail(resOnfo)
            }
        })

    }
   
}
