    //
    //  MainViewController.swift
    //  L2_Colchugina_Irina
    //
    //  Created by Ирина Кольчугина on 29.11.2020.
    //
    
    import UIKit
    import WebKit
    import Alamofire
    
    extension MainViewController: WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
            }
            
            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
                }
            
            let token = params["access_token"]
            Session.shared.token = token!
            decisionHandler(.cancel)
            self.performSegue(withIdentifier: "tapBarController", sender: nil)
            
            
            
            //        //список фото
//                    AF.request("https://api.vk.com/method/photos.get?album_id=profile&access_token=\(token!)&v=5.126").responseJSON { (response) in
//                        print(response)
//                    }
            //        //список групп
            //        AF.request("https://api.vk.com/method/groups.get?access_token=\(token!)&v=5.126").responseJSON { (response) in
            //            print(response)
            //        }
            //        //группы по поиску "love"
            //        AF.request("https://api.vk.com/method/groups.search?q=love&access_token=\(token!)&v=5.126").responseJSON { (response) in
            //            print(response)
            //        }
            
        }
    }
    
    
    class MainViewController: UIViewController {
        
        @IBOutlet weak var vkView: WKWebView! {
            didSet{
                vkView.navigationDelegate = self
            }
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "oauth.vk.com"
            urlComponents.path = "/authorize"
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: "7730758"),
                URLQueryItem(name: "display", value: "mobile"),
                URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                URLQueryItem(name: "scope", value: "262150"),
                URLQueryItem(name: "response_type", value: "token"),
                URLQueryItem(name: "v", value: "5.68")
            ]
            
            let request = URLRequest(url: urlComponents.url!)
            vkView.load(request)
            
          
            
            let tapForHiddenKeybourd = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tapForHiddenKeybourd)
            
            
            
        }
        
        @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            
        }
    }
    
    
