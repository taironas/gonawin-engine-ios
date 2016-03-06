//
//  GonawinAPIUserTests.swift
//  GonawinEngine
//
//  Created by Remy JOURDE on 01/03/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import GonawinEngine

class GonawinAPIUserTests: QuickSpec {
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("User endpoint") {
            var engine: AuthorizedGonawinEngine!
    
            beforeEach {
                engine = GonawinEngine.newStubbingAuthorizedGonawinEngine()
            }
    
            it("returns a user") {
        
                var user: User?
        
                engine.getUser(32102)
                    .catchError(self.logError)
                    .subscribeNext {
                        user = $0
                    }
                    .addDisposableTo(self.disposeBag)
        
                expect(user).toNot(beNil())
                
                expect(user?.name).to(equal("Foo Foo"))
            }
        }
    }
    
    func logError(error: ErrorType) -> Observable<User> {
        print("error : \(error)")
        
        return Observable.empty()
    }
}