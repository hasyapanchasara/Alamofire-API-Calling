# Alamofire-API-Calling
Alamofire API Calling Example

- Alamofire pod and implementation
- Swift 4
- GLOBAL singleton class
- API calling MVC structure
- GET and POST method
- Header parameter provision
- Retry count
- Completion handler
- Query Parameters
- Body Parameters
- Reachability POD and implementation
- Easy integration with Objective C

# POD commands and guideline

(1) Open terminal and go to location of your xcodeproj

(2) In terminal fire this command -> $pod init

(3) Open podfile

(4) Add below line of code befor 'end'

    pod 'Alamofire'
    pod 'ReachabilitySwift', '~> 3'
    
(5) Save and close podfile

(6) In terminal fire this command -> $pod install

# API Calling Swift 4 code

```
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.API_Formation_Function("email@email.com", password: "password12345")
    }

    
    func API_Formation_Function(_ userName : String , password : String) {
       
        EMReqeustManager.sharedInstance.apiLogin(userName, password: password) {
            (feedResponse) -> Void in
            
                // Show your progress HUD here
            
            if let downloadError = feedResponse.error{

                // Hide progress HUD here and show error if comes
            
            } else {
                if let dictionary = feedResponse.responseDict as? Dictionary<String, AnyObject>{
            
                    // Hide progress HUD here and show response
                    
                    let responseModel = EMResponseModel.init(jsonDict: dictionary)
                    
                    print(responseModel)
                    
                }
            }
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
```




<a href="https://www.paypal.me/hasya25/1"><img src="https://user-images.githubusercontent.com/23353196/30152617-4567dbc4-93d1-11e7-9b3a-20a9c92c1f50.png" style="max-width:100%;" width="170"></a>
