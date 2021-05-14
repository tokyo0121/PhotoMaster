//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 井ケ田　沙紀 on 2021/05/15.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //写真表示用
    @IBOutlet var photoImageView: UIImageView!
    
    //カメラ、アルバムの呼び出しメソッド
    func presentPickerController(sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    //写真が選択された時に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        //画像を出力
        photoImageView.image = info[.originalImage]as? UIImage
    }
    
    //元の画像にテキストを合成するメソッド
    func drawText(image: UIImage) -> UIImage{
        
        //テキスト内容
        let text = "Lifeis Tech!"
        
        //文字の特性
        let textFontAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial", size: 120)!,
            NSAttributedString.Key.foregroundColor: UIColor.red
        ]
        
        UIGraphicsBeginImageContext(image.size)
        
        //読み込んだ写真を書き出す
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        //定義
        let margin: CGFloat = 5.0 //余白
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    //イラストを追加するメソッド
    func drawMaskImage(image: UIImage) -> UIImage{
        
        //マスク画像の設定
        let maskImage = UIImage(named: "furo_ducky")!
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 50.0 //余白
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin, y: image.size.height - maskImage.size.height, width: maskImage.size.width, height: maskImage.size.height)
        
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //「カメラ」ボタンを押した時
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType: .camera)
    }
    
    
    //「アルバム」ボタンを押した時
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType: .photoLibrary)
    }
    
    //テキスト合成ブタンを押した時
    @IBAction func onTappedTextButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawText(image: photoImageView.image!)
        }else {
            print("画像がありません")
        }
    }
    
    //イラスト合成ボタンを押した時
    @IBAction func onTappedIllustButton(){
        if photoImageView.image != nil{
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else {
            print("画像がありません")
        }
    }
    
    //アップロードを押した時
    @IBAction func onTappedUploadButton(){
        if photoImageView.image != nil{
            //共有するアイテムを設定
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!, "#photoMaster"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }else {
            print("画像がありません")
        }
    }


}

