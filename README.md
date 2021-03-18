
# FUPLOAD Generator 
## What is it?

Fupload Generator provides a graphical interface to convert an excel spreadsheet (input file) to the apropriate format for a "fupload" into Banner SIS.  The program will validate the input and output files.  I designed the program for a specific university (you'll see our logo on the application) but it should work for any college that uses Banner SIS and needs to convert data for 'fupload'.   

## How do I use it?

You'll need a windows machine running powershell 4 or newer (any windows 10 machine should do the trick).

--Download and populate the Input File Template
+download the .ps1 file
+open and run the .ps1 file ('open with' powershell ise and hit the play button if you're a newbie)
+when the program opens you will see the data input tab, first select the input file on the  you populated earlier, the program will check for mistakes
+Fill out the remaining fields on the data input tab, if you don't the default values you see will be written to the output file.
+Go to the action tab and click "create fupload file" and follow the prompts.  If the button is greyed out you need to make sure you specified an input file in the input tab. 

## More info:
The base64 code in this script is an embedded image (it's the background picture), It could trigger your malware software or windows defender.  If so, make an exception in windows defender or your antimalware software for the script. You can find good guides online, just search.  If you dont trust the base64, (I dont blame you) just comment it out and carry on without the background image. 
