
import UIKit


protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func start(coordinator: Coordinator)
    func finish(coordinator: Coordinator)
    func removeChildren()
}

extension Coordinator {

    func start(coordinator: Coordinator) {
        self.children.append(coordinator)
        coordinator.parent = self
        coordinator.start()
    }

    func finish(coordinator: Coordinator) {
        guard let index = self.children.firstIndex(where: { $0 === coordinator })
        else { return }

        self.children.remove(at: index)
    }

    func removeChildren() {
        self.children.forEach { $0.removeChildren() }
        self.children.removeAll()
    }
}
