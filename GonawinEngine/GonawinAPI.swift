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
    case Users
}

extension GonawinAPI: TargetType {
    var baseURL: NSURL { return NSURL(string: "http://www.gonawin.com/j")! }
    
    var path: String {
        switch self {
        case .Auth:
            return "/auth"
        case .Users:
            return "/users"
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
        default:
            return nil
        }
    }
    
    var sampleData: NSData {
        switch self {
        case .Auth:
            return stubbedResponse("Auth")
        case .Users:
            return stubbedResponse("Users")
        }
    }
}

// MARK - Provider support

func stubbedResponse(filename: String) -> NSData! {
    @objc class TestClass: NSObject { }
    
    let bundle = NSBundle(forClass: TestClass.self)
    let path = bundle.pathForResource(filename, ofType: "json")
    return NSData(contentsOfFile: path!)
}
