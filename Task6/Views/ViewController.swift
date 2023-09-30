

import UIKit

class ViewController: UIViewController {
    
    var inch = -4
    private let productName = MakerView.shared.makeLabel(text: "Pizza with Mushrooms", textAlign: .center, font: .boldSystemFont(ofSize: 38),textColor: .black, lines: 2, autoResizing: false)
    
    
    private let productImage = UIImageView(image: UIImage(named: "pizza"))
 
    
    private let chooseSize = MakerView.shared.makeLabel(text: "Choose the size", textAlign: .center, font: .systemFont(ofSize: 22, weight: .medium),textColor: .black, autoResizing: false)
  
    private let price = MakerView.shared.makeLabel(text: "Price", textAlign: .center, font: .systemFont(ofSize: 14, weight: .medium),textColor: .gray, autoResizing: false)
  
    
    private let totalPrice = MakerView.shared.makeLabel(text: "$12.00",font: .systemFont(ofSize: 24, weight: .medium), textColor: .systemGreen, autoResizing: false)

    
    private let addToCart = MakerView.shared.makeButton(title: "Add to cart", font: .boldSystemFont(ofSize: 20), backgroundColor: .orange, cornerRadius: 15, tinitColor: .white, autoResizing: false)


    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 8
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let minusButton = MakerView.shared.makeButton(title: "-", titleColor: .black, font: .boldSystemFont(ofSize: 28), tinitColor: .black, autoResizing: false)


    
    private let plusButton = MakerView.shared.makeButton(title: "+", titleColor: .black, font: .boldSystemFont(ofSize: 28), autoResizing: false)
   
    
    private let countLabel = MakerView.shared.makeLabel(text: "1", textAlign: .center, font: .systemFont(ofSize: 24, weight: .medium), textColor: .black, background: .clear, autoResizing: false)
   
    
    let sizeOptions: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 38)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 15
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupStackView()
        setupCollectionView()
        setupNavigation()
    }
    
    
    private func setupStackView() {
        stackView.addArrangedSubview(minusButton)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)

        
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(plusButton)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)

        
        stackView.backgroundColor = .systemGray5
        stackView.distribution = .fillEqually
    }
    
    private func setupCollectionView() {
        sizeOptions.delegate = self
        sizeOptions.dataSource = self
        
        sizeOptions.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
    }
    
    private func setupNavigation() {
        self.title = "Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .done,
            target: self,
            action: #selector(likeProduct)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .done,
            target: self,
            action: #selector(likeProduct)
        )
        
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubviews(productName, productImage, chooseSize, sizeOptions, stackView, totalPrice, price, addToCart)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            productName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            productName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            
            productImage.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 20),
            productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 300),
            productImage.heightAnchor.constraint(equalToConstant: 230),
            
            chooseSize.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 30),
            chooseSize.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sizeOptions.topAnchor.constraint(equalTo: chooseSize.bottomAnchor, constant: 20),
            sizeOptions.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sizeOptions.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sizeOptions.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: sizeOptions.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 70),
            stackView.widthAnchor.constraint(equalToConstant: 230),
            
            totalPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            totalPrice.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            
            price.bottomAnchor.constraint(equalTo: totalPrice.topAnchor, constant: -5),
            price.leadingAnchor.constraint(equalTo: totalPrice.leadingAnchor),
            
            addToCart.widthAnchor.constraint(equalToConstant: 180),
            addToCart.heightAnchor.constraint(equalToConstant: 61),
            addToCart.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addToCart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func updatePrice(_ count: Int) {
        print(count)
        let price = Int(totalPrice.text ?? "12") ?? 12
        totalPrice.text = "$\(price * count)"
    }
    
    @objc func minusButtonTapped() {
        let count = Int(countLabel.text ?? "0")!
        if count != 0 {
            countLabel.text = String(count - 1)
            updatePrice(count - 1)
        }
    }
    
    @objc func plusButtonTapped() {
        let count = Int(countLabel.text ?? "0")!
        countLabel.text = String(count + 1)
        updatePrice(count + 1)
    }
    
    @objc func likeProduct() {
        
    }
    
}

