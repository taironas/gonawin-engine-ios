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
                    .catchError(self.log)
                    .subscribe(onNext: {
                        tournaments = $0
                    })
                    .addDisposableTo(self.disposeBag)
                
                expect(tournaments).toNot(beNil())
                
                expect(tournaments?.count).to(equal(3))
                
                expect(tournaments?[2].name).to(equal("2014 FIFA World Cup"))
            }
        }
        
        describe("Tournament endpoint") {
            var engine: AuthorizedGonawinEngine!
            
            beforeEach {
                engine = GonawinEngine.newStubbingAuthorizedGonawinEngine()
            }
            
            it("returns a tournament") {
                
                var tournament: Tournament?
                
                engine.getTournament(390036)
                    .catchError(self.log)
                    .subscribe(onNext: {
                        tournament = $0
                    })
                    .addDisposableTo(self.disposeBag)
                
                expect(tournament).toNot(beNil())
                
                expect(tournament?.name).to(equal("2014 FIFA World Cup"))
                
                expect(tournament?.participantsCount).to(equal(2))
                
                expect(tournament?.participants?[1].username).to(equal("jsmith"))
                
                expect(tournament?.teams?[1].name).to(equal("Test Team 2"))
                
                expect(tournament?.start).to(equal("12 June 2014"))
            }
        }
        
        describe("Tournament Calendar endpoint") {
            var engine: AuthorizedGonawinEngine!
            
            beforeEach {
                engine = GonawinEngine.newStubbingAuthorizedGonawinEngine()
            }
            
            it("returns a tournament calendar") {
                
                var tournamentCalendar: TournamentCalendar?
                
                engine.getTournamentCalendar(390036)
                    .catchError(self.log)
                    .subscribe(onNext: {
                        tournamentCalendar = $0
                    })
                    .addDisposableTo(self.disposeBag)
                
                expect(tournamentCalendar).toNot(beNil())
                
                expect(tournamentCalendar?.days.count).to(equal(1))
                
                expect(tournamentCalendar?.days[0].matches.count).to(equal(1))
            }
        }
        
        describe("Tournament Match Predict endpoint") {
            var engine: AuthorizedGonawinEngine!
            
            beforeEach {
                engine = GonawinEngine.newStubbingAuthorizedGonawinEngine()
            }
            
            it("returns a results of a predict") {
                
                var predict: Predict?
                
                engine.getTournamentMatchPredict(390036, matchId: 11310001, homeTeamScore: 1, awayTeamScore: 2)
                    .catchError(self.log)
                    .subscribe(onNext: {
                        predict = $0
                    })
                    .addDisposableTo(self.disposeBag)
                
                expect(predict).toNot(beNil())
                
                expect(predict?.homeTeamScore).to(equal(1))
                
                expect(predict?.awayTeamScore).to(equal(2))
            }
        }
    }
    
    func log(error: Error) -> Observable<[Tournament]> {
        print("error : \(error)")
        
        return Observable.empty()
    }

    func log(error: Error) -> Observable<Tournament> {
        print("error : \(error)")
        
        return Observable.empty()
    }
    
    func log(error: Error) -> Observable<TournamentCalendar> {
        print("error : \(error)")
        
        return Observable.empty()
    }
    
    func log(error: Error) -> Observable<Predict> {
        print("error : \(error)")
        
        return Observable.empty()
    }
}
