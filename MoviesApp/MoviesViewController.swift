//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by TEO on 16/11/22.
//

import UIKit
import Alamofire
import Kingfisher

class MoviesViewController: UIViewController {
    
    struct Const{
        static let URL_API = "https://www.omdbapi.com/?apikey=99cc4d2d&t="
        static let URL_NO_IMAGE = "https://www.fundaciontabitafeyes.org/wp-content/themes/childcare/images/default.png"
        static let VACIO = ""
    }

    @IBOutlet weak var nameMovieTextField: UITextField!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    @IBOutlet weak var awardsLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBAction func buttonSearchPressed() {
        search()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func search(){
        // Validar que el campo del nombre de la película no esté vacío
        if !nameMovieTextField.text!.isEmpty{
            //let urlString = Const.URL_API
            // Si no está vacío realizamos la busqueda
            
            let nameMovie = nameMovieTextField.text?.replacingOccurrences(of: " ", with: "%20")
            
            AF.request("https://www.omdbapi.com/?apikey=99cc4d2d&t=\(nameMovie ?? "")").responseDecodable(of: MovieModel.self) { (response) in
                
                
                  // Seteamos los elementos de la vista
                self.titleMovieLabel.text = response.value?.title
                self.releaseDateMovieLabel.text = response.value?.released
                self.awardsLabel.text = response.value?.awards
                self.actorsLabel.text = response.value?.actors
                self.countryLabel.text = response.value?.country
                
                let urlNoImage = Const.URL_NO_IMAGE
                
                // Poster de la movie
                guard let url = URL(string: response.value?.poster ?? urlNoImage) else { return }
                self.posterImageView.kf.setImage(with: url)
                
                // Limpiamos el campo de busqueda
                self.nameMovieTextField.text = Const.VACIO
            }
        }
    }


}

