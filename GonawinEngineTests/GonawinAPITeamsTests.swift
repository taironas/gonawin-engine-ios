//
//  GonawinAPITeamsTests.swift
//  GonawinEngine
//
//  Created by Remy JOURDE on 09/03/2016.
//  Copyright © 2016 Remy Jourde. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import GonawinEngine

class GonawinAPITeamsTests: QuickSpec {
    let disposeBag = DisposeBag()
    
    override func spec() {
        describe("Teams endpoint") {
            var engine: AuthorizedGonawinEngine!
            
            beforeEach {
                engine = GonawinEngine.newStubbingAuthorizedGonawinEngine()
            }
            
            it("returns a list of teams") {
                
                var teams: [Team]?
                
                engine.getTeams(1, count: 3)
                    .catchError(self.logError)
                    .subscribeNext {
                        teams = $0
                    }
                    .addDisposableTo(self.disposeBag)
                
                expect(teams).toNot(beNil())
                
                expect(teams?.count).to(equal(3))
                
                expect(teams?[2].name).to(equal("Substitutes"))
            }
        }
        
        describe("Team endpoint") {
            var engine: AuthorizedGonawinEngine!
            
            beforeEach {
                engine = GonawinEngine.newStubbingAuthorizedGonawinEngine()
            }
            
            it("returns a team") {
                
                var team: Team?
                
                engine.getTeam(4260034)
                    .catchError(self.logError)
                    .subscribeNext {
                        team = $0
                    }
                    .addDisposableTo(self.disposeBag)
                
                expect(team).toNot(beNil())
                
                expect(team?.name).to(equal("FooFoo"))
                
                expect(team?.membersCount).to(equal(4))
                
                expect(team?.members?[1].username).to(equal("jsmith"))
                
                expect(team?.tournaments?[2].name).to(equal("2015 Copa America"))
            }
        }
    }
    
    func logError(error: ErrorType) -> Observable<[Team]> {
        print("error : \(error)")
        
        return Observable.empty()
    }
    
    func logError(error: ErrorType) -> Observable<Team> {
        print("error : \(error)")
        
        return Observable.empty()
    }
}
