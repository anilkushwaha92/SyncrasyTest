//
//  Constant.swift
//  SyncracyTest
//
//  Created by Anil on 04/04/21.
//

import Foundation

struct Constant {
    static var APP_NAME = "com.twr.medianexus"
    struct APPURL {
        static private let baseUrl = "https://twr-stage.pimcoreclients.com/"
        
        private struct MainRoute {
            static let channellist = "api/channel"
        }
        private static let BaseUrl = baseUrl + MainRoute.channellist
        
        static var channelList : String{
            return BaseUrl + "/get_channel_list?"
        }
    }
    
}
