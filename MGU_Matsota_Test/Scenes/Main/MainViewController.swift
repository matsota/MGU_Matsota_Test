//
//  MainViewController.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Implementation
    public var networkManager: NetworkManager?
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = DemoRequest(0, direction: .zero)
        viewWasLoaded ? () : populateCollectionView(with: request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupCollectionView()
    }
    
    //MARK: - Private Implementation
    private var population: DemoResponse?
    private lazy var viewWasLoaded: Bool = false
    
    /// - `CollectionView`
    @IBOutlet private weak var collectionView: UICollectionView!
}









//MARK: - CollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// - `referenceSizeForHeaderInSection`
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    /// - `viewForSupplementaryElementOfKind`
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: MainCollectionReusableView.identifier, for: indexPath) as! MainCollectionReusableView
        let category_name = population?.category_name
        headerView.configure(title: category_name)
        return headerView
    }
    
    
    /// - `sizeForItemAt`
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = collectionView.frame.width / 2
        return CGSize(width: side - 15, height: side * 1.5)
    }
    
    /// - `numberOfItemsInSection`
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return population?.items.count ?? 0
    }
    
    /// - `cellForItemAt`
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
        let model = population?.items[indexPath.row]
        cell.populate(by: model)
        
        return cell
    }
    
    /// - `insetForSectionAt`
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

//MARK: - Custom protocols
extension MainViewController: Storyboarded, Loadable { }

//MARK: - Private Methods
private extension MainViewController {
    
    /// - `NavigationController`:
    func setupNavigationController() {
        let titleViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        let imageView = UIImageView()
        titleViewContainer.addSubview(imageView)
        imageView.frame = titleViewContainer.frame
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "oll-tv-literal-logo")
        imageView.image = image?.withTintColor(.white)
        
        navigationItem.titleView = titleViewContainer
        
        let leftButtonImage = UIImage(systemName: "chevron.left")
        let leftBarButton = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(leftBarAction(_:)))
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightButtonImage = UIImage(systemName: "chevron.right")
        let rightBarButton = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(rightBarAction(_:)))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc
    func leftBarAction(_ sender: UIBarButtonItem) {
        guard let identifier = population?.items.first?.id else {return}
        let request = DemoRequest(identifier, direction: .backward)
        populateCollectionView(with: request)
    }
    
    @objc
    func rightBarAction(_ sender: UIBarButtonItem) {
        guard let identifier = population?.items.last?.id else {return}
        let request = DemoRequest(identifier, direction: .forward)
        populateCollectionView(with: request)
    }
    
    /// - `CollectionView`
    func setupCollectionView() {
        collectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.register(MainCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MainCollectionReusableView.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func populateCollectionView(with request: DemoRequest) {
        viewWasLoaded = true
        showLoadingView()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.networkManager?.getDemo(request: request, success: { (response) in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.population = response
                    self.collectionView.reloadData()
                    self.hideLoadingView()
                }
            }, failure: { (localizedDescription) in
                guard let self = self else {return}
                
                var color = UIColor()
                if self.traitCollection.userInterfaceStyle == .dark {
                    color = .white
                } else {
                    color = .black
                }
                let configuration = AlertConfiguration(localizedDescription, color)
                DispatchQueue.main.async {
                    self.hideLoadingView()
                    UIRouter.instance.alert.default(from: self, with: configuration)
                }
            })
        }
    }
    
}
