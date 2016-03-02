//
//  GonawinAPIAuthTests
//  GonawinAPIAuthTests
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

class GonawinAPIAuthTests: QuickSpec {
    override func spec() {
        describe("Auth endpoint") {
            var gonawinEngine: GonawinEngine!
            
            beforeEach {
                gonawinEngine = GonawinEngine.newStubbingGonawinEngine()
            }
            
            let disposeBag = DisposeBag()
            
            it("returns a user") {
                
                let authData = AuthData(accessToken: "agjhfj", provider: "google", id: 0, email: "gonawin.test@gmail.com", name: "Gonawin Test")
                
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
    
    func logError(error: ErrorType) -> Observable<User> {
        print("error : \(error)")
        
        return Observable.empty()
    }
}
