//
//  ViewController.swift
//  TestAppInvite
//
//  Created by Anand on 31/05/17.
//  Copyright © 2017 Anand. All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn


class ViewController: UIViewController, GIDSignInUIDelegate, FIRInviteDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SignINAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()

    }

    @IBAction func SignOutAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }
   
    @IBAction func inviteAction(_ sender: Any) {
        if let invite = FIRInvites.inviteDialog() {
            invite.setInviteDelegate(self)
            
            // NOTE: You must have the App Store ID set in your developer console project
            // in order for invitations to successfully be sent.
            
            // A message hint for the dialog. Note this manifests differently depending on the
            // received invitation type. For example, in an email invite this appears as the subject.
            invite.setMessage("Try this out!\n -\(GIDSignIn.sharedInstance().currentUser.profile.name)")
            // Title for the dialog, this is what the user sees before sending the invites.
            invite.setTitle("Invites Example")
            invite.setDeepLink("https://yqg97.app.goo.gl/Zi7X")
            invite.setCallToActionText("Install!")
            invite.setCustomImage("https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png")
            invite.open()
        }
    }
}

