//
//  GonawinAPI.swift
//  GonawinEngine
//
//  Created by Remy JOURDE on 26/02/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Moya

enum GonawinAPI {
    case Auth(String, String, Int, String, String)
}

extension GonawinAPI: TargetType {
    var baseURL: NSURL { return NSURL(string: "http://www.gonawin.com/j")! }
    
    var path: String {
        switch self {
        case .Auth:
            return "/auth"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .Auth(let accessToken, let provider, let id, let email, let name):
            return [
                "access_token": accessToken,
                "provider": provider,
                "id": id,
                "email": email,
                "name": name
            ]
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .Auth:
            return "{ \"id\": 100, \"email\": \"foo@foo.com\", \"name\": \"Foo\", \"username\": \"foo\", \"auth\": \"gfjk\" }".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}

let GonawinProvider = MoyaProvider<GonawinAPI>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}
