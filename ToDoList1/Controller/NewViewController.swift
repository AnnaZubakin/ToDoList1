//
//  NewViewController.swift
//  ToDoList1
//
//  Created by anna.zubakina on 05/11/2023.
//

import UIKit

class NewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
      
        let backgroundImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        
               backgroundImageView.contentMode = .scaleAspectFill
               backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
               
               view.insertSubview(backgroundImageView, at: 0)
        
        
             NSLayoutConstraint.activate([
                   backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                   backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
        
      /*  NSLayoutConstraint.activate([
                backgroundImageView.widthAnchor.constraint(equalToConstant: 300), //
                backgroundImageView.heightAnchor.constraint(equalToConstant: 300), //
                backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]) */
        
               
        
    //    view.backgroundColor = .white
        let label = UILabel()
        label.text = "You opened new window"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
