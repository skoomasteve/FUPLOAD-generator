
# FUPLOAD Generator 
## What is it?

Fupload Generator provides a graphical interface to convert an excel spreadsheet (input file)  to the apropriate format for a "fupload" into Banner SIS.  The program will validate the input and output files.  Instructions are seen when the script is run.

## How do I use it?

You'll need a windows machine running powershell 4 or newer (any windows 10 machine should do the trick).

-Download and populate the Input File Template
-download the .ps1 file
-open and run the .ps1 file ('open with' powershell ise and hit the play button if you're a newbie)
-when the program opens you will see the data input tab, first select the input file on the  you populated earlier, the program will check for mistakes
-Fill out the remaining fields on the data input tab, if you don't the default values you see will be written to the output file.
-Go to the action tab and click "create fupload file" and follow the prompts.  If the button is greyed out you need to make sure you specified an input file in the input tab. 

## More info:
The base64 code in this script is an embedded image, It could trigger malware software or windows defender.  If so, make an exception in windows defender or your antimalware software for the script.  You can find good guides online, just search.  
