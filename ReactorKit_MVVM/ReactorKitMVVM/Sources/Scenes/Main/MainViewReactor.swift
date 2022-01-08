
import Foundation

import RxSwift
import ReactorKit


final class MainViewReactor: Reactor {

    enum Action {
        case plus
        case minus
    }

    enum Mutation {
        case plusValue
        case minusValue
    }

    struct State {
        var value: Int
    }

    var initialState: State


    init() {
        self.initialState = State(value: 0)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        print(#function)
        switch action {
        case .plus:
            return Observable.concat([
                Observable.just(Mutation.plusValue)
            ])
        case .minus:
            return Observable.concat([
                Observable.just(Mutation.minusValue)
            ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        print(#function)
        var state = state

        switch mutation {
        case .plusValue:
            state.value += 1
        case .minusValue:
            state.value -= 1
        }

        return state
    }
}
