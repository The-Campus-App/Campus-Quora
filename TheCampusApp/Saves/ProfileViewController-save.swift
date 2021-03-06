////
////  ProfileViewController.swift
////  TheCampusApp
////
////  Created by Yogesh Kumar on 27/09/19.
////  Copyright © 2019 Harsh Motwani. All rights reserved.
////
//
////visibleHeight = UIScreen.main.nativeBounds.height/UIScreen.main.nativeScale - navigationController!.navigationBar.frame.size.height - tabBarController!.tabBar.frame.size.height - UIApplication.shared.statusBarFrame.height
//
//import UIKit
//import Firebase
//
//class ProfileViewController: ColorThemeObservingCollectionViewController, UICollectionViewDelegateFlowLayout{
//    let headerID = "profileHeaderID"
//    let cellID = "profileCellID"
//    var headerHeight: CGFloat = 0
//    
//    var maxAnswerSize: CGSize!
//    var maxQuestionSize: CGSize!
//    var estimatedWidth: CGFloat!
//    
//    lazy var settingsButton: UIButton = {
//        let button = UIButton()
//        let size = CGSize(width: 30, height: 30)
//        let image = UIImage(named: "Settings")?.resizeImage(size: size).withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(ProfileViewController.launchSettings), for: .touchUpInside)
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupData()
//        estimateSize()
//        setupUI()
//        updateAccentColor()
//        updateTheme()
//        
//        // This is used to force collectionView to stick to safe layout
//        if #available(iOS 11.0, *) {
//            collectionView?.contentInsetAdjustmentBehavior = .always
//        }
//        
//        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
//        
//        collectionView.register(AnsweredPostCell.self, forCellWithReuseIdentifier: cellID)
//        
//        headerHeight = (UIScreen.main.nativeBounds.height/UIScreen.main.nativeScale) * 0.23
//    }
//    
//    override func setupNavigationBar(){
//        super.setupNavigationBar()
//        navigationItem.title = "Profile"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
//    }
//    
//    override func updateAccentColor() {
//        settingsButton.tintColor = selectedAccentColor.primaryColor
//    }
//    
//    override func updateTheme() {
//        collectionView.backgroundColor = selectedTheme.primaryColor
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    @objc func launchSettings(){
//        let settingsVC = SettingsViewController()
//        self.navigationController?.pushViewController(settingsVC, animated: true)
//    }
//    
//    func setupUI(){
//        
//    }
//    
//    var postsData: [CompletePost] = []
//    func setupData(){
//        let postData1 = CompletePost()
//        postData1.question = "This is a simple Question"
//        postData1.topAnswer = "This is a simple Answer. Click This cell to expand it"
//        postData1.topAnswerUserName = "Harsh Motwani"
//        postData1.dateAnswered = Date()
//        
//        let postData2 = CompletePost()
//        postData2.question = "This is a simple Question. Can Anyone Please answer it"
//        postData2.topAnswer = "This is a complex Answer such that it can occupy more space. Click This cell to expand it"
//        postData2.topAnswerUserName = "Yogesh Kumar"
//        postData2.dateAnswered = Date()
//        
//        let postData3 = CompletePost()
//        postData3.question = "This is a simple Question. Can Anyone Please answer it"
//        postData3.topAnswer = "This is a complex Answer such that it can occupy more space. But This thime I have increased it such that it can occupy three lines. Click This cell to expand it"
//        postData3.topAnswerUserName = "Yogesh Kumar"
//        postData3.dateAnswered = Date()
//        
//        let postData4 = CompletePost()
//        postData4.question = "This is a complex Question. It occupies three lines so it must be cut to two lines followed by ... Can Anyone Please answer it"
//        postData4.topAnswer = "This is a complex Answer such that it can occupy more space. But This thime I have increased it such that it can occupy four lines. It must be cut to two lines followed by ... Click This cell to expand it"
//        postData4.topAnswerUserName = "Yogesh Kumar"
//        postData4.dateAnswered = Date()
//        
//        postsData.append(postData1)
//        postsData.append(postData2)
//        postsData.append(postData3)
//        postsData.append(postData4)
//    }
//}
//
//// MARK:- Extension #2
//// This is for collectionViewHeader
//extension ProfileViewController{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        let width = collectionView.frame.width
//        return CGSize(width: width, height: headerHeight)
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
//        return header
//    }
//}
//
//// MARK:- Extension #2
//// This is for collectionViewcells
//extension ProfileViewController{
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0 //postsData.count
//    }
//    
//    func estimateSize(){
//        estimatedWidth = view.frame.width - 2 * postCellSidePadding
//        let maxAnswerHeight = CGFloat(numberOfLinesInAnswer) * String.findSingleLineHeight(width: estimatedWidth, attributes: [.font: answerFont])
//        let maxQuestionHeight = CGFloat(numberOfLinesInQuestion) * String.findSingleLineHeight(width: estimatedWidth, attributes: [.font: questionFont])
//        maxAnswerSize = CGSize(width: estimatedWidth, height: maxAnswerHeight)
//        maxQuestionSize = CGSize(width: estimatedWidth, height: maxQuestionHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let data = postsData[indexPath.item]
//        
//        let estimatedAnswerFrame = NSString(string: data.topAnswer ?? "").boundingRect(with: maxAnswerSize, options: .usesLineFragmentOrigin, attributes: [.font : answerFont], context: nil)
//        let estimatedQuestionFrame = NSString(string: data.question ?? "").boundingRect(with: maxQuestionSize, options: .usesLineFragmentOrigin, attributes: [.font : questionFont], context: nil)
//        let estimatedHeight = estimatedAnswerFrame.height + estimatedQuestionFrame.height + 50 + 35 + 15
//        return CGSize(width: estimatedWidth, height: estimatedHeight)
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
//        
//        if let cell = cell as? AnsweredPostCell{
//            cell.postData = postsData[indexPath.item]
//            if(indexPath.item) == 0{
//                cell.seperator.alpha = 0
//            }
//        }
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
////        return 0
////    }
//}
