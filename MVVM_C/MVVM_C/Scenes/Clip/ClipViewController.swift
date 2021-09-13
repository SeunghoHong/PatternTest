
import UIKit

import RxSwift
import PinLayout


final class ClipViewController: UIViewController {

    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIButton()

    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.sectionInset = .zero
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    init() {
        print(#function)
        super.init(nibName: nil, bundle: nil)
    }

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


extension ClipViewController {

    private func setup() {
        self.view.backgroundColor = .white

        self.collectionView.register(
            ClipCell.self,
            forCellWithReuseIdentifier: "ClipCell"
        )
        self.collectionView.backgroundColor = .green
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.view.addSubview(self.collectionView)

        self.headerView.backgroundColor = .black.withAlphaComponent(0.2)
        self.view.addSubview(self.headerView)

        self.titleLabel.text = "Clip"
        self.titleLabel.textColor = .white
        self.headerView.addSubview(self.titleLabel)
    }

    private func layout() {
        self.headerView.pin
            .top(self.view.pin.safeArea.top)
            .horizontally()
            .height(58.0)

        self.titleLabel.pin
            .center()
            .sizeToFit()

        self.collectionView.pin
            .all()
    }

    private func bind() {
        
    }
}


extension ClipViewController: UICollectionViewDataSource {

    var colors: [UIColor] { [.blue, .red] }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ClipCell",
            for: indexPath
        )

        cell.backgroundColor = colors[indexPath.item % 2]
        

        return cell
    }
}


extension ClipViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return collectionView.frame.size
    }
}


extension ClipViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("\(#function) \(indexPath)")
        guard let cell = cell as? ClipCell else { return }

        cell.willDisplay()
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("\(#function) \(indexPath)")
        guard let cell = cell as? ClipCell else { return }

        cell.didEndDisplaying()
    }
}
