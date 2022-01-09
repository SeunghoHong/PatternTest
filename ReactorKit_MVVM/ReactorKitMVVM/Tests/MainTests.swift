
import Foundation

import Nimble
import Quick

@testable import ReactorKitMVVM


final class MainTests: QuickSpec {

    override func spec() {
        describe("Main") {
            context("plus value") {
                let reactor = MainViewReactor()
                reactor.action.onNext(.plus)
                it("is equal 1") {
                    let result = reactor.currentState.value
                    expect(result).to(equal(1), description: "state plus")
                }
            }

            context("minus value") {
                let reactor = MainViewReactor()
                reactor.action.onNext(.minus)
                it("is equal -1") {
                    let result = reactor.currentState.value
                    expect(result).to(equal(-1), description: "state minus")
                }
            }
        }
    }

    func testActionPlus() {
//        let reactor = MainViewReactor()
//
//        let view = MainViewController()
//        view.reactor = reactor
//
//        reactor.stub.state.value =  MainViewReactor.State.init(value: 2)
//
//        XCTAssertEqual(view.valueLabel.text ?? "2", "2")
    }
}
