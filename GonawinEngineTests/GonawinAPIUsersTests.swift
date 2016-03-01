//
//  GonawinAPIUsersTests.swift
//  GonawinEngine
//
//  Created by Remy JOURDE on 01/03/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import Moya
@testable
import GonawinEngine

class GonawinAPIUsersTests: QuickSpec {
    override func spec() {
        describe("Users endpoint") {
            var gonawinEngine: GonawinEngine!
    
            beforeEach {
                let provider = RxMoyaProvider<GonawinAPI>(plugins: [NetworkLoggerPlugin(verbose: true)], stubClosure: MoyaProvider.ImmediatelyStub)
                gonawinEngine = GonawinEngine(provider: provider)
            }
    
            let disposeBag = DisposeBag()
    
            it("returns a user") {
        
                var users: [User]?
        
                gonawinEngine.getUsers()
                    .catchError(self.logError)
                    .subscribeNext {
                        users = $0
                    }
                    .addDisposableTo(disposeBag)
        
                expect(users?.count) == 3
            }
        }
    }
    
    func logError(error: ErrorType) -> Observable<[User]> {
        print("error : \(error)")
        
        return Observable.empty()
    }
}