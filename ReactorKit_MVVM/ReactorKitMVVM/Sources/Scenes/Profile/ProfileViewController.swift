
import UIKit


final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.layout()
    }
}


extension ProfileViewController {

    private func setup() {
        self.title = "Profile"
//        self.navigationController?.navigationBar.topItem?.title = ""

        self.view.backgroundColor = .white
    }

    private func layout() {
        
    }
}
