//
//  ViewController.swift
//  APIExample
//
//  Created by Aleksei Elin on 5.07.21.
//

import UIKit



final class ViewController: UIViewController {
 
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var gifImage: UIImageView!
    
    private var cityListButton: UIButton{
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    private var weatherOriginButton: UIButton{
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
        private var daysResponse : DaysResponseModel?
        private let dataFetcher = DataFetcherService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        gifImage.loadGif(name: "giphy")
        setupPageControll()
//        pageController.addTarget(self,
//                                 action: #selector(pageControllDidChanged(_:)),
//                                 for: .valueChanged)
        
        collectionView.register(cellType: WeatherCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        
      
        
        dataFetcher.getWeatherDays(count: 7, completion: { [weak self] response in
            guard let self = self, let response = response else { return }
            self.daysResponse = response
            self.collectionView.reloadData()
            
        })
        
    }
//    
//    override func viewDidLayoutSubviews() {
//       super.viewDidLayoutSubviews()
//       gifImage.frame = CGRect(x: 0 - view.safeAreaInsets.top, y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top)
//  
//   }
    
//    @objc func pageControllDidChanged(_ sender: UIPageControl){
//        let current = sender.currentPage
//        collectionView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width,
//                                                y: 0), animated: true)
//    }
    
     var pageController: UIPageControl{
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = daysResponse?.cnt ?? 7
        pc.currentPageIndicatorTintColor = .white
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }
    
    func setupPageControll(){
        view.addSubview(cityListButton)
        view.addSubview(weatherOriginButton)
//        cityListButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let pageControllerStackView = UIStackView(arrangedSubviews: [weatherOriginButton,pageController, cityListButton])
        pageControllerStackView.translatesAutoresizingMaskIntoConstraints = false
        pageControllerStackView.distribution = .fillEqually
        
        view.addSubview(pageControllerStackView)
        
        NSLayoutConstraint.activate([
            pageControllerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControllerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageControllerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageControllerStackView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
}
  


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return daysResponse?.cnt ?? 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: WeatherCollectionViewCell.self, for: indexPath)
        cell.backgroundColor = UIColor.clear
        pageController.currentPage = indexPath.row
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-10, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageController.currentPage = indexPath.row
    }
    
 
    
    
}


extension UICollectionView {
    public func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}

