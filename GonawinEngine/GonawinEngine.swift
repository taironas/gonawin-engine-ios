//
//  GonawinEngine.swift
//  GonawinEngine
//
//  Created by Remy JOURDE on 26/02/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Moya
import RxSwift

protocol GonawinEngineType {
    typealias T: TargetType, GonawinAPIType
    var provider: RxMoyaProvider<T> { get }
}

struct GonawinEngine: GonawinEngineType {
    typealias T = GonawinAPI
    let provider: RxMoyaProvider<GonawinAPI>
    
    func authenticate(authData: AuthData) -> Observable<User> {
        
        let endPoint = GonawinAPI.Auth(authData.accessToken, authData.provider, authData.id, authData.email, authData.name)
        
        return provider.request(endPoint)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapToObject(User)
    }
}

struct AuthorizedGonawinEngine: GonawinEngineType {
    typealias T = GonawinAuthenticatedAPI
    let provider: RxMoyaProvider<GonawinAuthenticatedAPI>
    
    func getUser(id: Int) -> Observable<User> {
        
        let endPoint = GonawinAuthenticatedAPI.User(id)
        
        return provider.request(endPoint)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapToObject(User)
    }
}