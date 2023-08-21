
//
//  HomeViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class HomeViewController: UIViewController{
    
    var sideMenuOpen = false
    var panGesture: UIPanGestureRecognizer!
    //parent
    
    @IBOutlet var parentView: UIView!
    
    // main view outlet
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainMenuTrailingConstrain: NSLayoutConstraint!
    @IBOutlet weak var mainMenubottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainMenutopConstraint: NSLayoutConstraint!
    @IBOutlet weak var MainMenuLeadingConstraint: NSLayoutConstraint!
    
    //side menu view outlet
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuContainer: UIView!
    
    // page colntrol view outlet
    @IBOutlet weak var pageControl: UIPageControl!
    
    // home collection view outlet
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    
    // demo imaged for collection view
    
    let collectionViewImages = ["slider_img1","slider_img2","slider_img3","slider_img4"]
    
    // whenever we navigate back in that case we want to hide the navigation 
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //for page controll
        pageControl.currentPage = 1
        pageControl.numberOfPages = collectionViewImages.count
        
        
        //nib register
        let reg = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        homeCollectionView.register(reg, forCellWithReuseIdentifier: "collectionviewcell")
        
        // collection view deligate and datasource
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        //  for removing navigation
        navigationController?.isNavigationBarHidden = true
        
        
        // Hiding the menue before loading
        self.sideMenuLeadingConstraint.constant = -self.sideMenuContainer.frame.width
        self.view.layoutIfNeeded()
        setupSideMenu()
        
       
        
    }
    
    // hamburgure button
    @IBAction func sideMenuButtonAction(_ sender: UIButton) {
        if sideMenuOpen{
            closeSideMenu()
        }else{
            openSideMenu()
        }
    }
    // search button
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        navigationController?.pushViewController(ProductViewController(nibName: "ProductViewController", bundle: nil), animated: true)
    }
    // setup pangesture and tapgesture
    func setupSideMenu() {
        // Initialize side menu view controller
        let sideMenuVC = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
        
        addChild(sideMenuVC)
        sideMenuContainer.addSubview(sideMenuVC.view)
        sideMenuVC.view.frame = sideMenuContainer.bounds
        sideMenuVC.didMove(toParent: self)
        
        
        // Initialize pan gesture recognizer
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        mainView.addGestureRecognizer(tapGesture)
        
    }
    
    // handel tap gesture
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        closeSideMenu()
    }
    
    // handel pan gesture
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        if gesture.state == .changed {
            let newPosition = sideMenuLeadingConstraint.constant + translation.x
            if newPosition >= 0 && newPosition <= sideMenuContainer.frame.width {
                sideMenuLeadingConstraint.constant = newPosition
            }
        } else if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            if velocity.x > 0 {
                openSideMenu()
                sideMenuOpen = true
            } else {
                closeSideMenu()
                sideMenuOpen = false
            }
        }
        
        gesture.setTranslation(.zero, in: view)
    }
    
    // open side menu code
    func openSideMenu() {
        sideMenuOpen = true
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = #colorLiteral(red: 0.07985462048, green: 0.05813284701, blue: 0.08785764135, alpha: 1)
            self.sideMenuLeadingConstraint.constant = 0
            self.MainMenuLeadingConstraint.constant = self.sideMenuContainer.frame.width
            self.mainMenutopConstraint.constant = 100
            self.mainMenubottomConstraint.constant = 100
            self.mainMenuTrailingConstrain.constant = self.sideMenuContainer.frame.width
            self.view.layoutIfNeeded()
        }
    }
    
    // close side menu code
    func closeSideMenu() {
        sideMenuOpen = false
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = #colorLiteral(red: 0.9599440694, green: 0.02287241258, blue: 0.09069452435, alpha: 1)
            self.sideMenuLeadingConstraint.constant = -self.sideMenuContainer.frame.width
            self.MainMenuLeadingConstraint.constant = 0
            self.mainMenutopConstraint.constant = 0
            self.mainMenubottomConstraint.constant = 0
            self.mainMenuTrailingConstrain.constant = 0
            
            self.view.layoutIfNeeded()
        }
    }
    
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: homeCollectionView.frame.width, height: homeCollectionView.frame.height )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionviewcell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell", for: indexPath) as! HomeCollectionViewCell
        collectionviewcell.cellImage.image = UIImage(named: collectionViewImages[indexPath.row])
        return collectionviewcell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
}

