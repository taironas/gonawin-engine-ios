//
//  GonawinEngine.swift
//  GonawinEngine
//
//  Created by Remy JOURDE on 26/02/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Moya
import RxSwift

class GonawinEngine {
    
    let provider: RxMoyaProvider<GonawinAPI>!
    
    init(provider: RxMoyaProvider<GonawinAPI>) {
        self.provider = provider
    }
    
    func authenticate(authData: AuthData) -> Observable<User> {
        
        let endPoint = GonawinAPI.Auth(authData.accessToken, authData.provider, authData.id, authData.email, authData.name)
        
        return provider.request(endPoint)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapToObject(User)
    }
}