//
//  UploadImageViewController.swift
//  JMSDJayasekara-COBSCCOMP192P-012
//
//  Created by Dilshan Jayasekara on 2021-03-08.
//

import UIKit
import FirebaseStorage
class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let storage = Storage.storage().reference()

    @IBAction func btnBackClick(_ sender: Any) {
        self.performSegue(withIdentifier: "UploadtoHome", sender: nil)
    }
    @IBOutlet weak var UploadImage: UIImageView!
    @IBAction func didTapUploadButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
               let url = URL(string: urlString)else {
             return
         }
         let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
             guard let data = data, error == nil else {
                 return
             }
             DispatchQueue.main.async {
                 let image = UIImage(data: data)
                 self.UploadImage.image = image
             }
         })
         task.resume()
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            picker.dismiss(animated: true, completion: nil)
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
                return
            }
            guard let imageData = image.pngData() else {
                return
            }
            storage.child("images/files.png").putData(imageData, metadata: nil, completion: { _, error in
                guard error == nil else {
                    print("Faild to Upload")
                    return
                }
                self.storage.child("images/files.png").downloadURL(completion: {url, error in
                    guard let url = url, error == nil else{
                        return
                    }
                    let urlString = url.absoluteString
                    DispatchQueue.main.async {
                        self.UploadImage .image = image
                    }
                    print("URL: \(urlString)")
                    UserDefaults.standard.set(urlString, forKey: "url")
                })
                
            })
        }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
          picker.dismiss(animated: true, completion: nil)
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
