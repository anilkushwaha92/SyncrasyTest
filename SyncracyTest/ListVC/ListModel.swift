//
//  ListModel.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import Foundation

enum ListModel{
    enum Process {
        struct Request {
            var type : String?
        }
        
        struct Response {
            var success : Bool
            var msg : String?
            var list : ListResponseModel?
        }
        struct ViewModel {
            var success : Bool
            var msg : String?
            var list : ListResponseModel?
        }
    }
}

struct ListResponseModel : Codable{
    let success : Bool?
    let data : [data]?
}

struct data : Codable {
    let cId : Int?
    let displayType : String?
    let thumbnail : String?
    let logoThumbnail : String?
    let lang : String?
    let languageCode : String?
    let name : String?
    let description : String?
    let promotionalVideo : [promotionalVideo]?
    let series : Bool?
    let subSeries : Bool?
    let episode : Bool?
    let myChannel : Bool?
    let archive : Bool?
    let media : Bool?
}

struct promotionalVideo : Codable {
    
}
