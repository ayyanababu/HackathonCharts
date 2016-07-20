//
//  globalObject.swift
//  mastGlobalTeam11
//
//  Created by Kartik Subramaniam on 17/07/16.
//  Copyright © 2016 Kartik Subramaniam. All rights reserved.
//

import Foundation

class GlobalObject :NSObject {

    let type_id,id ,user_session_id:Int

    init(id:Int,_ type_id:Int,_ user_session_id:Int) {
        
        self.id = id;
        self.type_id = type_id;
        self.user_session_id = user_session_id;
        super.init();
        
    }
  
  var q_name: String?
  var q_tag: String?
  var age: String?
  var location: String?
  var user_id: String?
  var event_type: String?
  var name: String?
  var count  = 1.0
  var sex : String?
  
  

}
