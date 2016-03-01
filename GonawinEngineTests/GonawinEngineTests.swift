//
//  GonawinEngineTests.swift
//  GonawinEngineTests
//
//  Created by Remy JOURDE on 26/02/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import Moya
@testable
import GonawinEngine

class GonawinEngineTests: QuickSpec {
    override func spec() {
        describe("Auth endpoint") {
            var gonawinEngine: GonawinEngine!
            
            beforeEach {
                let provider = RxMoyaProvider<GonawinAPI>(plugins: [NetworkLoggerPlugin(verbose: true)], stubClosure: MoyaProvider.ImmediatelyStub)
                gonawinEngine = GonawinEngine(provider: provider)
            }
            
            let disposeBag = DisposeBag()
            
            it("returns a user") {
                
                let authData = AuthData(accessToken: "agjhfj", provider: "google", id: 0, email: "foo@foo.com", name: "foo")
                
                var user: User?
                
                gonawinEngine.authenticate(authData)
                    .catchError(self.logError)
                    .subscribeNext {
                        user = $0
                    }
                    .addDisposableTo(disposeBag)
                
                expect(user).toNot(beNil())
            }
        }
    }
}

extension GonawinEngineTests {
    func logError(error: ErrorType) -> Observable<User> {
        print("error : \(error)")
        
        return Observable.empty()
    }
}
