//
//  DetailsViewController.swift
//  Recipe
//
//  Created by Nouran Alaa on 12/09/2021.
//

import Foundation
import UIKit
import Kingfisher
import SafariServices
import ImageSlideShow

class DetailsViewController : UIViewController  {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientLines: UILabel!
    @IBAction func recipeWebsite(_ sender: Any) {
        
        guard let recipeURL = URL(string: recipeData?.url ?? GenericString.NEW_LINE.rawValue) else { return }
            let svc = SFSafariViewController(url: recipeURL)
            present(svc, animated: true, completion: nil)
    }
    
    @IBAction func shareAs(_ sender: Any) {
        
        presenter?.didTapShare()
    }
    
    private var presenter : DetailsOutput?
    var recipeData : RecipeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        presenter?.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    private func initPresenter(){
        presenter = DetailsPresenter(view: self)
    }

}
extension DetailsViewController : DetailsInput{
    func handleImageGesture(){
        let kingfisherSource = [KingfisherSource(urlString: recipeData?.image ?? "")!]
        recipeImage.setImageInputs(kingfisherSource)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.didTap))
        recipeImage.addGestureRecognizer(gestureRecognizer)
    }
    func getSearchModel() -> SearchModel? {
        return nil
    }
    func fillRecipeData(){
        recipeTitle.text = recipeData?.label
        let url = URL(string: recipeData?.image ??  GenericString.EMPTY.rawValue)
//        recipeImage.kf.setImage(with: url,options: [.cacheOriginalImage])
        ingredientLines.text = recipeData?.ingredientLines.joined(separator: GenericString.NEW_LINE.rawValue)
    }
    func showShareOptions (){
        guard let recipeURL = URL(string: recipeData?.url ?? GenericString.NEW_LINE.rawValue) else { return }
            let activityViewController : UIActivityViewController = UIActivityViewController(
                activityItems: [recipeURL], applicationActivities: nil)

            // Anything you want to exclude
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo
            ]

        self.present(activityViewController, animated: true, completion: nil)
    }
}
