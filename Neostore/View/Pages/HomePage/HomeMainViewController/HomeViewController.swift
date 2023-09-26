
//
//  HomeViewController.swift
//  Neostore
//
//  Created by Neosoft on 17/08/23.
//

import UIKit

class HomeViewController: BaseViewController{
    
    // MARK: FILE VARIABLE
    var currentsidemenupage = 0
    var sideMenuOpen = false
    var panGesture: UIPanGestureRecognizer!
    var tapGesture: UITapGestureRecognizer!
    var viewmodel = HomepageViewModel()
    var currentscrollIndex = 1
    var contentOffset = CGPoint()
    var timer : Timer?
    
    // MARK: CONSTRAIN VARAIBLE
    @IBOutlet weak var mainMenuTrailingConstrain: NSLayoutConstraint!
    @IBOutlet weak var mainMenubottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainMenutopConstraint: NSLayoutConstraint!
    @IBOutlet weak var MainMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sideMenuContainer: UIView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        registerNib()
        setcollectionViewDeligate()
        setupPageControl()
        hideSideMenu()
        setupSideMenu()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        closeSideMenu()
    }
    
    // MARK: - Viewdiload function
    func hideSideMenu(){
        self.sideMenuLeadingConstraint.constant = -self.sideMenuContainer.frame.width
        self.view.layoutIfNeeded()
    }
    
    func registerNib(){
        let slidecell = UINib(nibName: cellRegNibConstant.homeCollectionViewCell, bundle: nil)
        homeCollectionView.register(slidecell, forCellWithReuseIdentifier: cellRegNibConstant.homeCollectionViewCell)
        
        let catgorycell = UINib(nibName: cellRegNibConstant.categoryCollectionCell, bundle: nil)
        categoryCollectionView.register(catgorycell, forCellWithReuseIdentifier: cellRegNibConstant.categoryCollectionCell)
    }
    func setupSideMenu() {
        let sideMenuVC = SideMenuViewController(nibName: navigationVCConstant.sideMenuVC, bundle: nil)
        addChild(sideMenuVC)
        sideMenuContainer.addSubview(sideMenuVC.view)
        sideMenuVC.view.frame = sideMenuContainer.bounds
        sideMenuVC.didMove(toParent: self)
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
    }
    
    func setcollectionViewDeligate(){
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    func setupPageControl(){
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewmodel.collectionViewImages.count
    }
    
    static func loadFromNib()-> UIViewController{
        return HomeViewController(nibName: navigationVCConstant.homeVC, bundle: nil)
    }
    
    // MARK: IB ACTIONS
    
    @IBAction func sideMenuButtonAction(_ sender: UIButton) {
        if sideMenuOpen{
            closeSideMenu()
        }else{
            openSideMenu()
        }
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        navigationController?.pushViewController(CartViewController.loadFromNib(), animated: true)
    }
    
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        closeSideMenu()
    }
    
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
    
    // MARK: SIDE MENU OPEN
    func openSideMenu() {
        sideMenuOpen = true
        UIView.animate(withDuration: 0.3) {
            self.mainView.addGestureRecognizer(self.tapGesture)
            self.view.backgroundColor = #colorLiteral(red: 0.07985462048, green: 0.05813284701, blue: 0.08785764135, alpha: 1)
            self.sideMenuLeadingConstraint.constant = 0
            self.MainMenuLeadingConstraint.constant = self.sideMenuContainer.frame.width
            self.mainMenutopConstraint.constant = 15
            self.mainMenubottomConstraint.constant = 15
            self.mainMenuTrailingConstrain.constant =  self.sideMenuContainer.frame.width
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: SIDE MENU CLOSE
    func closeSideMenu() {
        sideMenuOpen = false
        UIView.animate(withDuration: 0.3) {
            self.mainView.removeGestureRecognizer(self.tapGesture)
            self.parentView.removeGestureRecognizer(self.tapGesture)
            self.view.backgroundColor = ColorConstant.primary_red
            self.sideMenuLeadingConstraint.constant = -self.sideMenuContainer.frame.width
            self.MainMenuLeadingConstraint.constant = 0
            self.mainMenutopConstraint.constant = 0
            self.mainMenubottomConstraint.constant = 0
            self.mainMenuTrailingConstrain.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func PageControlAction(_ sender: UIPageControl) {
        let presentSelected = sender.currentPage
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        pageControl.currentPage = presentSelected
        currentscrollIndex = presentSelected
        
        let targetOffsetX = cellSize.width * CGFloat(presentSelected)
        homeCollectionView.setContentOffset(CGPoint(x: targetOffsetX, y: contentOffset.y), animated: true)
    }
    
    // MARK: TIMER FOR COLLECTION VIEW
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextItem() {
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        if currentscrollIndex >= viewmodel.categoryData.count {
            pageControl.currentPage = 0
            currentscrollIndex = 0
            homeCollectionView.setContentOffset(CGPoint(x: 0, y: contentOffset.y), animated: true)
        } else {
            pageControl.currentPage = currentscrollIndex
            let targetOffsetX = contentOffset.x + cellSize.width * CGFloat(currentscrollIndex)
            homeCollectionView.setContentOffset(CGPoint(x: targetOffsetX, y: contentOffset.y), animated: true)
            currentscrollIndex += 1
        }
    }
}


extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeCollectionView{
            return CGSize(width: UIScreen.main.bounds.width, height: homeCollectionView.bounds.height)
        }
        let availableWidth = UIScreen.main.bounds.width - 30
        let cellWidth = (availableWidth - 15) / 2
        return CGSize(width: cellWidth, height:cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryCollectionView{
            return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        }else{
            return UIEdgeInsets(top: 0 , left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeCollectionView{
            return viewmodel.collectionViewImages.count
        }else{
            return viewmodel.categoryData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == homeCollectionView{
            let collectionviewcell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRegNibConstant.homeCollectionViewCell, for: indexPath) as! HomeCollectionViewCell
            collectionviewcell.cellImage.image = UIImage(named: viewmodel.collectionViewImages[indexPath.row])
            return collectionviewcell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRegNibConstant.categoryCollectionCell, for: indexPath) as! CategoryCollectionCell
            cell.setContraints(lblname: viewmodel.categoryData[indexPath.row][homeCollectionViewConstant.name] as! String,
                               lblPosition: viewmodel.categoryData[indexPath.row][homeCollectionViewConstant.lblPosition] as! positions,
                               imgName: viewmodel.categoryData[indexPath.row][homeCollectionViewConstant.imgName] as! String,
                               imgPosition: viewmodel.categoryData[indexPath.row][homeCollectionViewConstant.imgPosition] as! positions)
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == categoryCollectionView{
            let selectedId = indexPath.row + 1
            print(selectedId)
            let productViewController = ProductViewController.loadFromNib() as! ProductViewController
            productViewController.id = selectedId
            self.navigationController?.pushViewController(productViewController, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
        pageControl.currentPage = currentPage
    }
}
