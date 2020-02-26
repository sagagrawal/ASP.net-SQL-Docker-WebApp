# ASP.net-app-for-PigmyAgent
This repo contains an application developed in ASP.net with SQL being the database for Pigmy Agent those work for co-operative bank. 
_____________________________________________________________________________________________________
To host this app on your local system using Docker, all you need to do is below:
1. Install Docker Desktop on your local system(switch to Windows Containers)
2. Download the project on your local system(Unzip it)
3. Go to Directory ./Host_with_Docker/
4. Run GetAppHosted.bat
5. Go to link http://localhost:8000/
_____________________________________________________________________________________________________
To get this app working on your local system, kindly follow below steps:
1. Download this project solution on your local system(zip format)
2. Extract the project files where in you would find a Database backup file stored in /Sql Database backup/ folder
3. Restore this Database on your local system (You can use SQL Server Management Studio for this to restore the database easily). Or You can run the commands that I have backed-up in a text file to create a database from scratch.
4. After performing above steps you should see database tables and stored procedures loaded.
5. Enable IIS Services on your local system or you should be fine using Visual Studio localhost server to host this app.
6. Run this app, you would be redirected to Login.aspx page, Enter login credentials that exists in database and have fun around going through the app.

The app is basically more useful for the Agent who work for a co-operative bank as a Pigmy Agent and needs to maintain all the transactional records, and I have tried to digitize that process using this app.

Also, this app has been built using Bootstrap web framework and hence, it automatically gets adjusted as per the device you are accessing this on!
