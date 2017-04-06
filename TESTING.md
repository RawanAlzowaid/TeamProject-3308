Who：

-Mengchen Gong  
-Ziyang Yang  
-Rawan Alzowaid  
-Max Schwarz  
-Obaid Alquhtani  


Title: WeShare


Version:

We hope that WeShare helps create a safer environment by helping people(CU students) manage their waste. And we will be encouraging them to do so by the idea that they can get some amount of money instead of just throwing things away. We also want to help others save money by getting good quality second-hand things that they need. Along with building a cooperative society that gives a helping hand to those in need by donating our stuff to them.
Thus, we hope that WeShare would help us: protect the environment by managing our waste so that minimizing human's impact on the environment; get people the stuff they need or want at a lower cost (like by swapping with other users or spending few bucks to buy the secondhand, or for free), and make the community more unified on reducing environmental impact and financial responsibility.


Automated Tests:

1.xcode includes an automation feature called UIAtomation that test drive our applicatin via writting scripts. It estimates how the user would react with our application and shows an editor log which contains log messeges and log types for every test that you write. 

2.Please check the attached screenshots for the test in the repository. Description：

-----Screenshot1: This is the test for the program when we build and run the project at the navigation. The test results got out when we click buttoms, type in informations and do other manipulations.

-----Screenshot2: This is the Debug page after we build and run the project that it shows the status of the project and to show if there is any place we need to change.

-----Screenshot3: This is the screenshot of our login page, which contains several functions, like entering email and password, the link to find the password if forgot, link to sign up and go back to the previous page. And we tested everything, which works pretty well.     

-----Screenshot4: This is the searching page that help people to find what they want or interest in. It also contain two links which are ‘login’ and ’Sign up’. The proposal is helping people, and make the search more convenience.

-----Screenshot5: This is the ’Sign up’ page which let the new user to create a profile. And you need to input some important information, such like name, email, password, address and such on. And there are two links which are ‘Login’ and ‘Go back’. To help people to log in and go to the previous page. 

-----Screenshot6: This is the Categories page of WeShare. We have several categories which are Books, Electronics, Furniture, Toys & Games, Clothes and Accessories. We contain all the things that people maybe interest in or needed and these things can be swap with others or be secondhand. And we have the ‘Go back’ link in case user want to search something.

-----Screenshot7-Screenshot12(except 10): They are the categories' pages with more detailed sub categories of each type. For Books, we have arts & photography, biography, children, cooking, sci-fi, history, mystery, romance, literature and textbooks. For furniture, we cateforied in living room, kitchen, bedroom and dining room. For Aacessaries, we have rings, bracelet, glasses, headwares, necklace, earrings, bags & luggages. For electricities, we have subcategories: camera, television, watches, tablets ,laptops, printers, headphones and phones. For clothes, we categories in tops, bottoms, dresses, and shoes. For the toy & game part, as the consider of not much of the toys and games will be saled, we did not category them more into smaller sub-categories.

-----Screenshot10: It is the picture taking and picture choosing for adding the items for sell



User Acceptance Tests Plans (UAT Plans):

TEST:1

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
    
TEST:2 

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
    
TEST:3 

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
    
TEST:4

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
