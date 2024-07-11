import UIKit

class ComingSoonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Membuat sebuah UIView
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 10 // membuat sudut-sudut melengkung
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)

        // Membuat UIImageView
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo") // ganti dengan nama gambar Anda
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)

        // Membuat UILabel
        let label = UILabel()
        label.text = "Coming Soon"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)

        // Mengatur Auto Layout untuk containerView
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        // Mengatur Auto Layout untuk imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 125)
        ])

        // Mengatur Auto Layout untuk label
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.performSegue(withIdentifier: "goBackToLevel", sender: self)
    }
    
}
