//
//  GonawinAPITournamentsTests.swift
//  GonawinEngine
//
//  Created by Remy JOURDE on 11/03/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import GonawinEngine

class GonawinAPITournamentsTests: QuickSpec {
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("Tournaments endpoint") {
            var engine: AuthorizedGonawinEngine!
            
            beforeEach {
                engine = GonawinEngine.newStubbingAuthorizedGonawinEngine()
            }
            
            it("returns a list of tournaments") {
                
                var tournaments: [Tournament]?
                
                engine.getTournaments(1, count: 3)
                    .catchError(self.logError)
                    .subscribeNext {
                        tournaments = $0
                    }
                    .addDisposableTo(self.disposeBag)
                
                expect(tournaments).toNot(beNil())
                
                expect(tournaments?.count).to(equal(3))
                
                expect(tournaments?[2].name).to(equal("2014 FIFA World Cup"))
            }
        }
    }
    
    func logError(error: ErrorType) -> Observable<[Tournament]> {
        print("error : \(error)")
        
        return Observable.empty()
    }
}
