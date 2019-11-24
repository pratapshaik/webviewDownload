//
//  ViewController.swift
//  webviewDownload
//
//  Created by pratap shaik on 24/11/19.
//  Copyright © 2019 pratap shaik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  let myURL = URL(string:"https://docs.blackberry.com/en/development-tools/blackberry-dynamics-sdk-ios/4_2/blackberry-dynamics-sdk-ios-devguide/yje1489614127934/spb1490189556738/gan1498838313017")
       
        let myURL = URL(string: "https://www.princexml.com/samples/")

              let myRequest = URLRequest(url: myURL!)
              webView.loadRequest(myRequest)
              print("Webpage Loaded Successfully")
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
          print("webViewDidStartLoad")
         
      }
    
    
      public func webViewDidFinishLoad(_ webView: UIWebView){
          print("webViewDidFinishLoad")
        
      }
    
    
      public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
          print("didFailLoadWithError")
          
      }
      
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool{
          print("ABCd")
        if let url = request.url, navigationType == UIWebView.NavigationType.linkClicked {
           // return false
            print("#ABCd______________",url)
            savePdf(urlString:url.absoluteString, fileName:"shaik")
        }
          return true
      }

    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "YourAppName-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!",actualPath)
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    
     func showSavedPdf(url:String, fileName:String) {
            if #available(iOS 10.0, *) {
                do {
                    let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                    for url in contents {
                        if url.description.contains("\(fileName).pdf") {
                           // its your file! do what you want with it!

                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
    }
    
    // check to avoid saving a file multiple times
    func pdfFileAlreadySaved(url:String, fileName:String)-> Bool {
        var status = false
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("YourAppName-\(fileName).pdf") {
                        status = true
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
        return status
    }

}

