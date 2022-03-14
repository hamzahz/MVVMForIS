//
//  ViewController.swift
//  MVVMForIS
//
//  Created by Hamza on 3/13/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelLoading: UILabel!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loading.bind { value in
            self.labelLoading.text = value
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.labelLoading.text = ""
    }

    @IBAction func didTapLogin(_ sender: Any) {
        viewModel.getAuthentication(userName: self.textFieldUserName.text, password: self.textFieldPassword.text) { user, error in
            if error != nil {
                self.labelLoading.text = ""
                let alert = Constant.showAlert(title: "Alert", message: String(describing: error!))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WaitingViewController") as? WaitingViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}

