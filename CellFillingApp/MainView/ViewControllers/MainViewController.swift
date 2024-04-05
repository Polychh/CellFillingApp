//
//  ViewController.swift
//  CellFillingApp
//
//  Created by Polina on 04.04.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private let createCellButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("СОТВОРИТЬ", for: .normal)
        button.titleLabel?.font = UIFont(name: ConstsFonts.robotoMedium, size: 14) ?? UIFont()
        button.titleLabel?.textColor = .white
        button.backgroundColor = ConstsColors.customPurple
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstrains()
        configureCollectionView()
        configButton()
        configNavigationController()
    }
}

//MARK: - Configure UITableView
private extension MainViewController{
    func configNavigationController(){
        navigationItem.title = "Клеточное наполнение"
    }
    
    func configureCollectionView(){
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.resuseID)
    }
    
    func configButton(){
        createCellButton.addTarget(self, action: #selector(tappedbutton), for: .touchUpInside)
    }
    
    @objc func tappedbutton(){
        presenter.generateRandomLive()
    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol{
    func scrollToDown(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.resuseID, for: indexPath) as? MainCell else { return UICollectionViewCell() }
        let data = presenter.data[indexPath.row]
        cell.configCell(titleLabelText: data.title, subTitleLabelText: data.subTitle, image: data.image)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 
        let availableWidth = view.bounds.width - (padding * 2)
        let widthPerItem = availableWidth
        return CGSize(width: widthPerItem, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

//MARK: - Set Constrains
private extension MainViewController{
    func setConstrains(){
        view.backgroundColor = ConstsColors.customBacgroundColor
        view.addSubview(collectionView)
        view.addSubview(createCellButton)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: createCellButton.topAnchor,constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
         
            createCellButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createCellButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            createCellButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            createCellButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
