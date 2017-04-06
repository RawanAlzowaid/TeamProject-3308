Who
-Mengchen Gong
-Ziyang Yang
-Rawan Alzowaid
-Max Schwarz
-Obaid Alquhtani

Title: Weshare

Version
We hope that WeShare helps create a safer environment by helping people manage their waste. And we will be encouraging them to do so by the idea that they can get some amount of money instead of just throwing things away. We also want to help others save money by getting good quality second-hand things that they need.  Along with building a cooperative society that gives a helping hand to those in need by donating our stuff to them.
Thus, we hope that WeShare would help us: protect the environment by managing our waste / minimizing human's impact on the environment, get people the stuff they need/want at a lower cost (like by swapping with other users) or for free and make the community more unified on reducing environmental impact and on financial responsibility.

Automated Tests: ????????????
Try to ask that if the build method in Xcode count as testing, if we screenshot the code page after build. 
Also, xcode automatically contain a test code itself, how can we use that or modify that some way to let it be the automate test file.

User Acceptance:

NO:1
Use case name
    Verify registration with login and password
Description
    Test the account registration and login to user protected space in app
Pre-conditions
    User has downloaded the app and is on the launch page
Test steps
    1. Navigate to register page
    2. Provide username
    3. Provide password
    4. Navigate to user protected page
Expected result
    User information should be stored in database
Actual result
    User navigates to home page in app
Status (Pass/Fail)
    Pass
Notes
    N/A
Post-conditions
    User is added in database and thier profile information in database is validated.
    
NO:2 
Use case name
    Finding supplies
Description
    Test the searching and finding method
Pre-conditions
    User can search supplies through categories
Test steps
    1. Type in supplies users want to search
    2. Chooce different supplies' categories
    3. Check items in different sub-catefories
    4. Find supplies
Expected result
    User should be able to search items
Actual result
    User is navigated to page to page successful following different categories
Status (Pass/Fail)
    Pass
Notes
    Need to find the keywords in users' searching words
Post-conditions
    User is be able to seach different items they want easily
    
NO:3 
Use case name
    Location Access 
Description
    Test the ability for the app to access location services and to update database with current location.
Pre-conditions
    User has successfully logged in to protected space in app  
Test steps
    1. User logs in to app
    2. App automatically updates database with users current location
    3. If not allowed access to location, ask user for location
    4. Press find location button
    5. Verify results are same and database reflects correct location
Expected result
    Correct location is updated in database  
Actual result
    App shows: "showing results for (location)" 
Status (Pass/Fail)
    Pass
Notes
    N/A
Post-conditions
    The account's session location is updated in database
    
NO:4
Use case name
    Verify camera use in app
Description
    Test the app's access to the camera and the ability to add an img to database
Pre-conditions
    User has navigated to add item page 
Test steps
    1. Click icon to take picture
    2. Take picture
    3. Confirm picture taken
Expected result
    User should be able to take a picture of item
Actual result
    User sees item successfully added alert
Status (Pass/Fail)
    Pass
Notes
    N/A
Post-conditions
    Camera should be accessed and image taken should be added in database under the user
