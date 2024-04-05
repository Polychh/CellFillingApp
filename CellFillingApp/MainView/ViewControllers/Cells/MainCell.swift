//
//  MainViewCell.swift
//  CellFillingApp
//
//  Created by Polina on 04.04.2024.
//


import UIKit

final class MainCell: UICollectionViewCell {
    static let resuseID = "MainCell"
    
    private var gradientLayer: CAGradientLayer?
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let cellImage = UIImageView()
    
    private let smileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = ConstsColors.customPurple
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIElements()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setUpUIElements
    private func setUpUIElements(){
        configLabel(label: titleLabel, weithText: .bold, lines: 1, font: UIFont(name: ConstsFonts.robotoMedium, size: 20) ?? UIFont())
        configLabel(label: subTitleLabel, weithText: .regular, lines: 1, font: UIFont(name: ConstsFonts.robotoRegular, size: 14) ?? UIFont())
        configImageView(imageView: cellImage)
    }
    //MARK: - configLabel
    private func configLabel(label: UILabel, weithText: UIFont.Weight, lines: Int, font: UIFont){
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = lines
        label.font = font
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    //MARK: - configImageView
    private func configImageView(imageView: UIImageView){
        imageView.layer.cornerRadius = 40 / 2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        for sublayer in cellImage.layer.sublayers ?? [] {
            if let gradientLayer = sublayer as? CAGradientLayer {
                gradientLayer.removeFromSuperlayer()
            }
        }
    }
    //MARK: - Lineargradient
    private func linearGradient(view: UIView, color1: UIColor, color2: UIColor){
        if let gradientLayer = gradientLayer {
            gradientLayer.removeFromSuperlayer()
        }
        let newGradientLayer = CAGradientLayer()
        newGradientLayer.colors = [color1.cgColor, color2.cgColor]
        newGradientLayer.locations = [0.0, 1.0]
        newGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.insertSublayer(newGradientLayer, at: 0)
        gradientLayer = newGradientLayer
    }
    
    override func layoutSubviews() { 
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        gradientLayer?.frame = cellImage.bounds
    }
}

//MARK: - Configure Cell UI
extension MainCell{
    func configCell(titleLabelText: TitleType, subTitleLabelText: SubTitleType, image: ImageType){
        titleLabel.text = titleLabelText.rawValue
        subTitleLabel.text = subTitleLabelText.rawValue
        switch image{
        case .live:
            linearGradient(view: cellImage, color1: ConstsColors.liveColorFirst, color2: ConstsColors.liveColorSecond)
            smileImage.image = UIImage(systemName: ConstImages.live)
        case .dead:
            linearGradient(view: cellImage, color1: ConstsColors.deadColorFirst, color2: ConstsColors.deadColorSecond)
            smileImage.image = UIImage(systemName: ConstImages.dead)
        case .newLive:
            linearGradient(view: cellImage, color1: ConstsColors.newLiveColorFirst, color2: ConstsColors.newLiveColorSecond)
            smileImage.image = UIImage(systemName: ConstImages.newLive)
        }
    }
}

//MARK: - SetUp Constrains
extension MainCell{
    private func setConstrains(){
        backImage.addSubview(cellImage)
        backImage.addSubview(titleLabel)
        backImage.addSubview(subTitleLabel)
        contentView.addSubview(backImage)
        cellImage.addSubview(smileImage)
        
        NSLayoutConstraint.activate([
            
            backImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            smileImage.centerXAnchor.constraint(equalTo: cellImage.centerXAnchor),
            smileImage.centerYAnchor.constraint(equalTo: cellImage.centerYAnchor),
            smileImage.heightAnchor.constraint(equalToConstant: 20),
            smileImage.widthAnchor.constraint(equalToConstant: 20),
            
            cellImage.topAnchor.constraint(equalTo: backImage.topAnchor, constant: 16),
            cellImage.leadingAnchor.constraint(equalTo: backImage.leadingAnchor, constant: 16),
            cellImage.heightAnchor.constraint(equalToConstant: 40),
            cellImage.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: backImage.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: backImage.trailingAnchor,constant: -16),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: backImage.trailingAnchor,constant: -16),
        ])
    }
}
