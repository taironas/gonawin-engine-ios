//
//  GonawinAPIActivityTests.swift
//  GonawinEngine
//
//  Created by Remy JOURDE on 06/03/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import GonawinEngine

class GonawinAPIActivityTests: QuickSpec {
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("Activities endpoint") {
            var engine: AuthorizedGonawinEngine!
            
            beforeEach {
                engine = GonawinEngine.newStubbingAuthorizedGonawinEngine()
            }
            
            it("returns a list of activities") {
                
                var activities: [Activity]?
                
                engine.getActivities(1, count: 2)
                    .catchError(self.logError)
                    .subscribeNext {
                        activities = $0
                    }
                    .addDisposableTo(self.disposeBag)
                
                expect(activities).toNot(beNil())
                
                expect(activities?.count).to(equal(2))
            }
        }
    }
    
    func logError(error: ErrorType) -> Observable<[Activity]> {
        print("error : \(error)")
        
        return Observable.empty()
    }
}