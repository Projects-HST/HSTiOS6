//
//  Biography.swift
//  OPS
//
//  Created by Happy Sanz Tech on 01/01/21.
//

import UIKit

class Biography: UIViewController,BiographyView {
 
    @IBOutlet weak var personalTitle: UILabel!
    @IBOutlet weak var politicalTitle: UILabel!
    @IBOutlet weak var personalText: UILabel!
    @IBOutlet weak var politicalText: UILabel!
    
    var presenter = BiographyPresnter(biographyService: BiographyService())
    var resp = [BiographyData]()
    
    var personalLifeTa = String()
    var personalLifeEn = String()
    var politicalCarrerTa = String()
    var politicalCarrerEn = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callAPI()
        politicalTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "political-carrer_text", comment: "")
        personalTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "personal_text", comment: "")
    }
    
    func callAPI() {
        presenter.attachView(view: self)
        presenter.getBiography(user_id: GlobalVariables.shared.user_id)
    }
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }

    func setBio(bio: [BiographyData]) {

        resp = bio
        for datas in resp {
            let persLifeTa = datas.personal_life_text_ta
            let persLifeEn = datas.personal_life_text_en
            let politicalTa   = datas.political_career_text_ta
            let politicalEn   = datas.political_career_text_en

            self.personalLifeTa.append(persLifeTa!)
            self.personalLifeEn.append(persLifeEn!)
            self.politicalCarrerTa.append(politicalTa!)
            self.politicalCarrerEn.append(politicalEn!)
            
            if LocalizationSystem.sharedInstance.getLanguage() == "en"
            {
            self.personalText.setHTMLFromString(text: personalLifeEn)
            self.politicalText.setHTMLFromString(text: politicalCarrerEn)
            }
            else
            {
            self.personalText.setHTMLFromString(text: personalLifeTa)
            self.politicalText.setHTMLFromString(text: politicalCarrerTa)
            }
            print(personalLifeTa)
        }
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: "O.P.S", message: errorMessage, complition: {
        })
    }
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
//setHTMLFromString(text: personalLifeEn)
