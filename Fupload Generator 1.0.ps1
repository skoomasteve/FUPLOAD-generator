﻿#______________________________________________________________________

## FUPLOAD GENERATOR ##

#### Copyright 2020 - MIT Licesnse   Author: Steven Soward  ####

#_______________________________________________________________________

##  This program provides a graphical interface to convert an excel spreadsheet (input file)  to the apropriate format for a "fupload" into Banner SIS.  The program will validate the input and output files.  Instructions are seen when the script is run.

## This program requires a windows machine runing powershell 4 or newer.  

#######################################
## PERMANANT DATA MAPPING:  CHANGE THE VARIABLES BELOW TO ALTER DATA OUTPUT:
#######################################

$RULECLASSCODE = "JE16"
$BANKCODE = "1C"
$CHARTCODE = "1"

#subtract one from desired line length
$linelength = 148
#######################################

###  --  To change the position of a value:

#   If you need to change the position of something you can scroll down to find the header, body, and footer sections, the variables and column positions are defined there.

#   -note- if you need to edit the colomn position of a variable, subtract one from the desired number.  Also keep in mind that the currency values are all right alligned and padded either 7 or 10 from the row specified in the code

###  -- To specify a new source column/field to the output file:

#   Scroll down to the "COLUMN NAME TO VARIABLE MAPPING" section and specify new colum heading to be read, you'll need to insert or append the new column 
#   heading variables next to the nearest existing variable (based on the output row specified).    
# 

###DEFINES THE DATE FORMAT

#$Sdate = Get-Date -Format 'MM-dd-yyyy.HH.mm'
$date = Get-Date -Format 'MM-dd-yyyy.HH.mm'
Add-Type -AssemblyName PresentationFramework

Function checkcreditdebit{	
 $badlines = 0
    import-csv "$env:temp\$date-tmpfupload.csv" | ForEach {
    $ctotal = 0
    $dtotal = 0
    $ctotal += $_.credit
    $dtotal += $_.debit
    $cvsd = $ctotal+$dtotal
    If ($_.credit -gt '0' -And $_.debit -gt '0') { $badlines += 1
       
      
      } 
   



    }
if ($badlines -gt 0) { 
    $userresponse=[System.Windows.MessageBox]::Show("$badlines line(s) have both credit and debit fields populated.
    Please fix the input file credit/debit fields and try again")}
    
if ($badlines -eq 0 -and $cvsd -gt 1) { 
    $userresponse=[System.Windows.MessageBox]::Show("Input file passed credit/debit validation")}


}


######################################################
#Get-Filename Function
######################################################

    Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    if ($OpenFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { $OpenFileDialog.FileName }
    $Global:SelectedFile = $OpenFileDialog.FileName
    $inputfilequickviwbutton.enabled = $True
    $generatefilebutton.enabled = $true
} #end function Get-FileName

#####csv conversion function 

function convertcsv {

    $extn = [IO.Path]::GetExtension($SelectedFile)
    if ($extn -eq (".xlsx") -or (".xls") ) 
    {
$xlCSV=6
$xls=$SelectedFile
$csv="$env:temp\$date-tmpfupload.csv"
$xl=New-Object -com "Excel.Application"
$wb=$xl.workbooks.open($xls)
$wb.SaveAs($csv,$xlCSV)
$xl.displayalerts=$False
$xl.quit()
$xl.quit()
    
    
}}

#######################################################
#Fupload processor  - function
#######################################################
Function makefupload{	
   #______________________________________________________________________









###redundant assembly addition

Add-Type -AssemblyName PresentationFramework


#



#############
### INITIAL MESSAGE  (this tells the user what the input format needs to look like)

$userresponse=[System.Windows.MessageBox]::Show('This utility will use the specified .CSV or Excel file to generate the FUPLOAD file to a .txt file.



-Excel must be installed on your machine in order to import excel files

If you do not use the template to input the data, The fourth row/line of your custom input file must have at least the following column headings, each in an UNMERGED cell: 

Fund
Orgn
Acct
Prog
Actv
Locn
Debit
Credit


   
Press OK to process your specified input file', 'OBU FUPLOAD File Generator','ok')
if ($UserResponse -eq "ok" ) 
{

#Yes activity (script will move on since this is null)
##### maybe put the script here?

} 

else 

{
    #something else
    
}

$descriptionprompt = $textbox4.text
$SYSID =  $textbox3.text



#######_____________PROGRESS BAR STUFF, IGNORE THE NEXT MANY LINES UNTIL THE NEXT "####" COMMENT: -- ___________________________


$script:StartTime
$outputpath="C:\Users\$env:UserName\Desktop"	## --- Put Folder-Path Here 
If (Test-Path $outputpath) {
	Write-Host
	Write-Host "Generating Fupload file" -ForegroundColor "Yellow"
	Write-Host "=========================================" -ForegroundColor "Yellow"


Add-Type -assembly System.Windows.Forms

	## -- Create The Progress-Bar
	$ObjForm = New-Object System.Windows.Forms.Form
	$ObjForm.Text = "OBU Fupload File Generator"
	$ObjForm.Height = 200
	$ObjForm.Width = 500
	$ObjForm.BackColor = "White"

	$ObjForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
	$ObjForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

	## -- Create The Label
	$ObjLabel = New-Object System.Windows.Forms.Label
	$ObjLabel.Text = "Starting, Please wait ... "
	$ObjLabel.Left = 5
	$ObjLabel.Top = 10
	$ObjLabel.Width = 500 - 35
	$ObjLabel.Height = 80
	$ObjLabel.Font = "Tahoma,11"
	## -- Add the label to the Form
	$ObjForm.Controls.Add($ObjLabel)

	$PB = New-Object System.Windows.Forms.ProgressBar
	$PB.Name = "PowerShellProgressBar"
	$PB.Value = 30
	$PB.Style="Continuous"

	$System_Drawing_Size = New-Object System.Drawing.Size
	$System_Drawing_Size.Width = 500 - 40
	$System_Drawing_Size.Height = 1
	$PB.Size = $System_Drawing_Size
	$PB.Left = 5
	$PB.Top = 40
    $PB.Value = 70 
	$ObjForm.Controls.Add($PB)

	## ---- Show the Progress-Bar and Start The PowerShell Script
	$ObjForm.Show() | Out-Null
	$ObjForm.Focus() | Out-NUll
	$ObjLabel.Text = "Generating the File.  
Please Wait ... "
    $objform.TopMost = $True
	$ObjForm.Refresh()



#--------------------------------------------------------------

####__________  Converts to Selected File to CSV if the selected file is an Excel file

#--------------------------------------------------------------

$extn = [IO.Path]::GetExtension($SelectedFile)
    if ($extn -eq (".xlsx") -or (".xls") ) 
    {
$xlCSV=6
$xls=$SelectedFile
$csv="C:\Users\$env:UserName\Desktop\FUPtemporaryfile.csv"
$xl=New-Object -com "Excel.Application"
$wb=$xl.workbooks.open($xls)
$wb.SaveAs($csv,$xlCSV)
$xl.displayalerts=$False
$xl.quit()
$xl.quit()
$selectedfile=$csv

}





#############################################

###SKIPS THE TOP THREE LINES OF THE INPUT FILE

#############################################
#$log = Get-Content -Path $csv
#$snippet = $log[3..($log.count - 0)]
#$snippet>$csv






####################################

#  WRITES HEADER FILE

####################################
$desireddate = $textbox1.text

$HEADER = "                                                                              "
$HEADER = $HEADER.INSERT(0,"$SYSID")
$HEADER = $HEADER.Insert(16,"1")
$HEADER = $HEADER.INSERT(17,"$desireddate")

$HEADER >> C:\Users\$env:UserName\Desktop\tempFUPfile-$date.txt 





####################################

###IMPORTS THE FILE PREVIOUSLY DESIGNATED AND BEGINS PROCESSING DATA FOR EACH LINE OF DATA PAST THE HEADER

####################################


$Result = import-csv $csv | ForEach-object {


#####################################################################################
 
#####   COLUMN NAME TO VARIABLE MAPPING  ####################  

#    edit the " $_. " variables as needed if there is a change to the input file column headings

#####################################################################################

$Fund = $_.fund
$Orgn = $_.org
$Acct = $_.acct
$Prog = $_.prog
$Actv = $_.actv
$Locn = $_.locn
$Debit = $_.debit
$Credit = $_.credit
$builtindescription = $_.description1


#####  some other variables defined and combined here

$recordcount = $recordcount +1
$debittotal = [int]$debit + [int]$debittotal
$Credittotal = [int]$credit + [int]$credittotal
$lineamount = [int]$credit + [int]$debit
$bodytwo = '2'
#$lineamount = [string]$lineamount
$lineamount = ([string]$lineamount).PadLeft(12,'0')







#If ($_credit -lt '0.1' -or $_debit -lt '0.1') {
# $userresponse=[System.Windows.MessageBox]::Show('At least one line has a NEGATIVE value for credit or debit,
# Please fix the input file credit/debit fields and try again')

#exit

#} 


#####################################

##Determines the credit code by process of elimination

#####################################

if ([string]::IsNullOrEmpty($_.Credit)) {
$creditordebitcode = "D"
}
else
{
$creditordebitcode = "C"
 }


#### variable later used to truncate the description after description is entered

$descriptiontruncate = "                                                                        "


####################################

#### Console status updates:



Write-Host "writing a line for record #$recordcount"  -ForegroundColor "Magenta"
Write-Host "THIS $_.description"



###POPULATES THE DESCRIPTION WITH EITHER/BOTH PROMPT AND BUILTIN DESCRIPTION

$description = "$buitindescription"




###MAKES SURE THERE AREN'T ANY COMMAS OR DECIMAL POINTS IN $Credit & $debit

#$Credit = $credit -replace ‘[,.]’,''
#$debit = $debit -replace ‘[,.]’,''


        



##########################################################################################################################################################
##THIS BLOCK OF CODE INSTERTS THE DATA INTO THE APPROPRIATE LINE POSITIONS || EDIT THE NUMBERS TO CHANGE WHERE THE DATA IS WRITTEN 
##  THESE ONLY EFFECT THE TRANSACTION (body) SECTION OF THE OUTPUT FILE, NOT THE FIRST LINE OR LAST TWO LINES.
##########################################################################################################################################################
$Body1 = "                                                                                                                                                                                                                                                                                                                                                                                                                       "

$Body1 = $Body1.Insert(0,"$SYSID")
$Body1 = $Body1.Insert(16,"$bodytwo")
$Body1 = $Body1.Insert(17,$ruleclasscode)
$Body1 = $Body1.Insert(21,$recordcount)
$Body1 = $Body1.Insert(29,$lineamount)
$Body1 = $Body1.Insert(42,$Description)
$Body1 = $Body1.Insert(75,$descriptiontruncate)
$Body1 = $Body1.Insert(76,$creditordebitcode)
$Body1 = $Body1.Insert(77,$bankcode)
$Body1 = $Body1.Insert(79,$chartcode)
$Body1 = $Body1.Insert(86,$fund)
$Body1 = $Body1.Insert(91,$orgn)
$Body1 = $Body1.Insert(98,$acct)
$Body1 = $Body1.Insert(104,$prog)
$Body1 = $Body1.Insert(110,$actv)
$Body1 = $Body1.Insert(116,$locn)






$Body1 >> C:\Users\$env:UserName\Desktop\tempFUPfile-$date.txt 

###console output for credits/debits

IF([string]::IsNullOrEmpty($credit)) {            
    Write-Host "$debit written as debit for record #$recordcount" -ForegroundColor "Yellow"           
} else {            
    Write-Host "$Credit written as credit for record #$recordcount" -ForegroundColor "blue"  
          
}


## ignore the following progress bar code:
#++++++++++

}
   # $zeero = 1
   # $reference = $SelectedFile.count

          
	foreach ($line  in Get-Content C:\Users\$env:UserName\Desktop\tempFUPfile-$date.txt) {
		## -- Calculate The Percentage Completed
		$Counter++
		[Int]$Percentage = ($Counter/3500)
		$PB.Value = $Percentage
		$ObjLabel.Text = "Writing File to $env:UserName\Desktop\tempFUPfile-$date.txt"
		$ObjForm.Refresh()
		#Start-Sleep -Milliseconds 1500
		# -- $Item.Name
		#"`t" + $Item.Path

	}

	$ObjForm.Close()
	Write-Host "`n"
}

Else {
	Write-Host
	Write-Host "`t Cannot Execute The Script." -ForegroundColor "Yellow"
	Write-Host "`t $outputpath Does Not Exist in the System." -ForegroundColor "Yellow"
	Write-Host
}
#+++++++++++++++++++++++


#_____________________________________
#      Footer
#_____________________________________


$footerline1 = "                                                                                                                                                    "
$footerline2 = "                                                                                                                                                    "
$footerthree = '3'
$footerfour = '4'
$footerrecordcount = $recordcount 
$debitspluscredits = [int]$debittotal + [int]$Credittotal
#$debitspluscredits = [int]$debitspluscredits 

###RIGHT ALLIGNMENT FOR FOOTER VAIRABLE OUTPUT - ".PADLEFT" PADS WITH the '0' specified a specific number of spaces
#$footerrecordcount.PadLeft(8,'0')
#$debitspluscredits.Padleft(12,'0')

$footerrecordcount = ([string]$footerrecordcount).PadLeft(8,'0')
$debitspluscredits = ([string]$debitspluscredits).PadLeft(12,'0')





##first footer line:
$footerline1 = $footerline1.Insert(0,$SYSID)
$footerline1 = $footerline1.Insert(16,$footerthree)
$footerline1 = $footerline1.Insert(17,$footerrecordcount)
$footerline1 = $footerline1.Insert(25,$debitspluscredits)


$footerline1 >> C:\Users\$env:UserName\Desktop\tempFUPfile-$date.txt 

#second footer line:
$footerline2 = $footerline2.Insert(0,$SYSID)
$footerline2 = $footerline2.Insert(16,$footerfour)
$footerline2 = $footerline2.Insert(17,$description)
$footerline2 = $footerline2.Insert(65,"                                 ")
$footerline2 = $footerline2.Insert(67,"$env:UserName OBU")

$footerline2 >> C:\Users\$env:UserName\Desktop\tempFUPfile-$date.txt 

$filedate = get-date -format 'MMM-dd'
$year = get-date -Format 'yyyy'

#<_____________________________________ -- Truncate each Line to specified size -- _________________________________
$finalfile = "C:\Users\$env:UserName\documents\FUPLOAD\$year\$filedate\FUPLOADfile-$date.txt" 

$tempfile = "C:\Users\$env:UserName\Desktop\tempFUPfile-$date.txt"
#subtract 1 from your desired line length if you need to change it

$linenumberpad = 1
$one=1
$calculatedpad = ($linelength)-($_.length)
$calculatedpad = ($calculatedpad)+($one)
Get-Content -path $tempfile | ForEach {

    If ($_.Length -lt $linelength) {

        $_.padright($calculatedpad) 
        write-host "Line $linenumberpad has been padded"

    } Else {

       

        $_.Substring(0,$linelength)  
        write-host "Line $linenumberpad has been truncated"

    }
    $linenumberpad += 1
    #________________________________ --- saves the final version of the file --- ______________________
} | Out-File ( New-Item -Path "$Finalfile" -Force )
$Quickviewcontent = "$env:temp\quickviewcontent.csv"
"   " > "$env:temp\quickviewcontent.csv"
Get-Content -raw $finalfile >> $quickviewcontent
#>


# ------------------------creates UNIX Line endings in the file-------------------------
$fileforeolcovert = $finalfile

$filecontent = [IO.File]::ReadAllText($fileforeolcovert) -replace "`r`n", "`n"
[IO.File]::WriteAllText($fileforeolcovert, $filecontent)



#------Clean up temp file


Remove-Item $tempfile
#Remove-Item -path C:\Users\$env:UserName\Desktop\FUPtemporaryfile.csv 

#_______________________________________ --- Clean up variables for multiple runs --- _________________________

$emailfuploadbutton.enabled = $false
$viewfuploadbutton.enabled = $True

remove-item $csv -force
remove-item $tempfile -force

#_______________________________________ --- Ending Notification --- _________________________
#^^^
start-Process -FilePath C:\Windows\explorer.exe -ArgumentList "/select, ""$finalfile"""


## Thanks to Boe Prox we can have a notification popup to notify us of file completion.
### his code is below    -ss
Function Invoke-BalloonTip {
    <#
    .Synopsis
        Display a balloon tip message in the system tray.
    .Description
        This function displays a user-defined message as a balloon popup in the system tray. This function
        requires Windows Vista or later.
    .Parameter Message
        The message text you want to display.  Recommended to keep it short and simple.
    .Parameter Title
        The title for the message balloon.
    .Parameter MessageType
        The type of message. This value determines what type of icon to display. Valid values are
    .Parameter SysTrayIcon
        The path to a file that you will use as the system tray icon. Default is the PowerShell ISE icon.
    .Parameter Duration
        The number of seconds to display the balloon popup. The default is 1000.
    .Inputs
        None
    .Outputs
        None
    .Notes
         NAME:      Invoke-BalloonTip
         VERSION:   1.0
         AUTHOR:    Boe Prox
    #>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True,HelpMessage="The message text to display. Keep it short and simple.")]
        [string]$Message,

        [Parameter(HelpMessage="The message title")]
         [string]$Title="Attention $env:username",

        [Parameter(HelpMessage="The message type: Info,Error,Warning,None")]
        [System.Windows.Forms.ToolTipIcon]$MessageType="Info",
     
        [Parameter(HelpMessage="The path to a file to use its icon in the system tray")]
        [string]$SysTrayIconPath='C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe',     

        [Parameter(HelpMessage="The number of milliseconds to display the message.")]
        [int]$Duration=10000
    )

    Add-Type -AssemblyName System.Windows.Forms

    If (-NOT $global:balloon) {
        $global:balloon = New-Object System.Windows.Forms.NotifyIcon

        #Mouse double click on icon to dispose
        [void](Register-ObjectEvent -InputObject $balloon -EventName MouseClick -SourceIdentifier IconClicked -Action {
            #Perform cleanup actions on balloon tip
            #Write-Verbose 'Disposing of balloon'
            #start-Process -FilePath C:\Windows\explorer.exe -ArgumentList "/select, "C:\users\steven.soward\documents\copyctr_111020_13149.txt""
            #$global:balloon.dispose()
            #Unregister-Event -SourceIdentifier IconClicked
            #Remove-Job -Name IconClicked
            #Remove-Variable -Name balloon -Scope Global
        })
    }

    #Need an icon for the tray
    $path = Get-Process -id $pid | Select-Object -ExpandProperty Path

    #Extract the icon from the file
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($SysTrayIconPath)

    #Can only use certain TipIcons: [System.Windows.Forms.ToolTipIcon] | Get-Member -Static -Type Property
    $balloon.BalloonTipIcon  = [System.Windows.Forms.ToolTipIcon]$MessageType
    $balloon.BalloonTipText  = $Message
    $balloon.BalloonTipTitle = $Title
    $balloon.Visible = $true

    #Display the tip and specify in milliseconds on how long balloon will stay visible
    $balloon.ShowBalloonTip($Duration)

    Write-Verbose "Ending function"

}

Invoke-BalloonTip -Message "The Fupload file has been generated as $finalfile" -Title 'File Created' -MessageType  Info  

<## FINAL MESSAGE BOX
$userresponseend=[System.Windows.MessageBox]::Show("The Fupload file has been generated and placed on your desktop", 'FUPLOAD File Generator','ok')
if ($UserResponseend -eq "ok" ) 
{

#Yes activity

} 

else 

{ 

exit

} 
}
#######################################################
#>
# UI components
#
#######################################################

}

$base64 = "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
"
$date = Get-Date -Format MM-dd-yy-hh.mm

$Content = [System.Convert]::FromBase64String($Base64)
   Set-Content -Path "$env:temp\bk$date-.jpg" -Value $Content -Encoding Byte



$background = "$env:temp\bk$date-.jpg" 

function PromptWithTabs(
    [String] $title,
            [Object] $caller
    ){
            [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
            [void] [System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')
			$width = 1120
			$Height = 560
            $f = New-Object System.Windows.Forms.Form
            

            $panel1 = new-object System.Windows.Forms.TabPage
            $panel2 = new-object System.Windows.Forms.TabPage
            $panel3 = new-object System.Windows.Forms.TabPage
	$textbox1 = new-object System.Windows.Forms.TextBox
	$textbox2 = new-object System.Windows.Forms.TextBox
    $textbox3 = new-object System.Windows.Forms.TextBox
    $textbox4 = new-object System.Windows.Forms.TextBox
    
    
    $textbox1.text = " YYYYMMDD"
    $textbox2.text = " <--Select an Input File"
    $textbox3.text = "COPYCTR"
    $textbox4.text = "JE Description"

	
	$generatefilebutton = new-object System.Windows.Forms.Button
    $Emailfuploadbutton = new-object System.Windows.Forms.Button
    $inputfilequickviwbutton = new-object System.Windows.Forms.Button
    $viewfuploadbutton = new-object System.Windows.Forms.Button
    $choseinputfilebutton = new-object System.Windows.Forms.Button
    
            $tab_control1 = new-object System.Windows.Forms.TabControl
            $panel1.SuspendLayout()
            $panel2.SuspendLayout()
            $panel3.SuspendLayout()
	$f.BackgroundImage = [System.Drawing.Image]::FromFile("$background")
	
	
	$f.Text = $title
	$f.AutoSize = $true
	
	##disables/enables maximise
	$f.MaximizeBox = $false
	##Prevents resizing
	$f.FormBorderStyle = "FixedSingle"
	$F.StartPosition = "CenterScreen"
	
            $tab_control1.SuspendLayout()


            $f.SuspendLayout()
    
            $panel2.Controls.Add($textbox1)
            $panel2.Controls.Add($textbox2)
            $panel2.Controls.Add($textbox3)
            $panel2.Controls.Add($textbox4)
            $panel2.Location = new-object System.Drawing.Point(4, 22)
            $panel2.Name = "tabPage2"
            $panel2.Padding = new-object System.Windows.Forms.Padding(3)
            $panel2.Size = new-object System.Drawing.Size(600, 300)
            $panel2.TabIndex = 1
            $panel2.Text = "Data Input Tab"
    
            $textbox1.Location = new-object System.Drawing.Point(72, 7)
            $textbox1.Name = "textBoxMessage"
            $textbox1.Size = new-object System.Drawing.Size(160, 30)
            $textbox1.TabIndex = 0
	
	$textbox2.Location = new-object System.Drawing.Point(142, 44)
	$textbox2.Name = "textBoxMessage2"
	$textbox2.Size = new-object System.Drawing.Size(160, 30)
    $textbox2.TabIndex = 0
    
    $textbox3.Location = new-object System.Drawing.Point(79, 84)
	$textbox3.Name = "textBoxMessage3"
	$textbox3.Size = new-object System.Drawing.Size(160, 30)
    $textbox3.TabIndex = 0
    
    $textbox4.Location = new-object System.Drawing.Point(79, 124)
	$textbox4.Name = "textBoxMessage4"
	$textbox4.Size = new-object System.Drawing.Size(160, 30)
	$textbox4.TabIndex = 0
	
	
	
	
    ########Labels - tab 2
    #  label 1
			$l1 = New-Object System.Windows.Forms.Label
			$l1.Text = 'File Date'
            $l1.Location = New-Object System.Drawing.Size(12,11)
            $l1.Size = New-Object System.Drawing.Size(60,30)
            
    
            $l1.Font = new-object System.Drawing.Font('Microsoft Sans Serif', 8, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, 0);
            $panel2.Controls.Add($l1)

        
                ####label 2, tab 2
            $l2 = New-Object System.Windows.Forms.Label
            $l2.Text = 'Sys. ID'
            $l2.Location = New-Object System.Drawing.Size(21,88)
            $l2.Size = New-Object System.Drawing.Size(50,30)
            
            $l2.Font = new-object System.Drawing.Font('Microsoft Sans Serif', 8, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, 0);
              $panel2.Controls.Add($l2)


            ####label 4, tab 2
            $l4 = New-Object System.Windows.Forms.Label
            $l4.Text = 'JE Description'
            $l4.Location = New-Object System.Drawing.Size(0,127)
            $l4.Size = New-Object System.Drawing.Size(75,30)
            
            $l4.Font = new-object System.Drawing.Font('Microsoft Sans Serif', 8, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, 0);
            $panel2.Controls.Add($l4)


            
            
            
            
            
            


            $panel2.controls.add($choseinputfilebutton)
            $panel2.controls.add($inputfilequickviwbutton)
            $textbox1.Add_Leave( {
              
                if ($sender.Text.length -eq " YYYYMMDD") {
                  $l1.Text = 'Input required'
                  # [System.Windows.Forms.MessageBox]::Show('Input required')
                  $tab_control1.SelectedIndex = 1
                  $sender.Select()
                  $result = $sender.Focus()
                } else {
				$l1.Text = ''
                
                
				
				
			}
			
			
		})
            $panel1.Controls.Add($generatefilebutton)
	$panel1.Controls.Add($Emailfuploadbutton)
    $panel1.controls.add($viewfuploadbutton)

   
	
            $panel1.Location = new-object System.Drawing.Point(4, 22)
            $panel1.Name = "tabPage1"
            $panel1.Padding = new-object System.Windows.Forms.Padding(3)
            $panel1.Size = new-object System.Drawing.Size(600, 300)
            $panel1.TabIndex = 0
	$panel1.Text = "Action Tab"
    $panel2.Controls.Add($textbox1)

	
	##################
	#     Write Fupload File Button
	
            $generatefilebutton.Location = new-object System.Drawing.Point(104, 27)
            $generatefilebutton.Name = "buttonShowMessage"
            $generatefilebutton.Size = new-object System.Drawing.Size(107, 44)
            $generatefilebutton.TabIndex = 0
            $generatefilebutton.Text = "Create Fupload file"
            $generatefilebutton_Click = {
                makefupload
               
              
               
                
                
                $Newtext = "(Get-Content -Path $finalfile -Raw)  -replace ‘[,.]’,'' "
                #-replace "(?s)`r`n\s*$"
                "[system.io.file]::WriteAllText($finalfile,$Newtext)"
            } 
	$generatefilebutton.Add_Click($generatefilebutton_Click)
	$generatefilebutton.enabled = $False

	##################
	#     Email Fupload Button

	
	
	$emailfuploadbutton.Location = new-object System.Drawing.Point(104, 91)
	$emailfuploadbutton.Name = "buttonShowMessage"
	$emailfuploadbutton.Size = new-object System.Drawing.Size(107, 44)
	$emailfuploadbutton.TabIndex = 0
	$emailfuploadbutton.Text = "Email Fupload File"
	$emailfuploadbutton_Click = {

        Add-Type -AssemblyName Microsoft.VisualBasic
        $desiredemail = [Microsoft.VisualBasic.Interaction]::InputBox('Specify Email Address', 'Enter email address(es)', "someone@college.edu")
        if ($desiredemail -eq " ")
        {
            
            exit
            
        }
        
        else
        {
            
            #nothing
            
        }
        
        $Today = (Get-Date)
      
      #  
      
      
        
        $SMTPserver = "#enteraddress"
        $from = "#enteraddress"
        $to = "$desiredemail"
        $subject = "Fupload File"
        $attText = "EmailAttachment"
        $attName = "Fupload-$date.txt"
        $mailer = new-object Net.Mail.SMTPclient($SMTPserver)
        $msg = new-object Net.Mail.MailMessage($from, $to, $subject, $emailbody)
        $attach = new-object net.mail.attachment("$finalfile")
        $msg.Attachments.Add($attach)
        $msg.IsBodyHTML = $false
        $emailbody = "
        
        _____________________________________________
        
        Automated export of Fupload Files

      
        _____________________________________________
        
        Generated by Steven's Accounting Stack
        _____________________________________________"
      
        
        
        $mailer.send($msg)
       
        





        
       
	}
	$emailfuploadbutton.Add_Click($emailfuploadbutton_Click)
	$emailfuploadbutton.enabled = $false
	##################
	#     View Fupload Button
	$viewfuploadbutton.Location = new-object System.Drawing.Point(104, 157)
	$viewfuploadbutton.Name = "buttonShowMessage"
	$viewfuploadbutton.Size = new-object System.Drawing.Size(107, 44)
	$viewfuploadbutton.TabIndex = 0
	$viewfuploadbutton.Text = "Inspect Fupload File"
	$viewfuploadbutton_Click = {
        import-csv $env:temp\quickviewcontent.csv  |Out-GridView -Title "Output File Inspector" -wait | format-wide 

            
		
	}
	$viewfuploadbutton.Add_Click($viewfuploadbutton_Click)
	
	$viewfuploadbutton.enabled = $false
	################
            $panel2.Location = new-object System.Drawing.Point(4, 22)
            $panel2.Name = "tabPage2"
            $panel2.Padding = new-object System.Windows.Forms.Padding(3)
            $panel2.Size = new-object System.Drawing.Size(259, 52)
            $panel2.TabIndex = 1
            $panel2.Text = "Data Input Tab"
    
            $textbox1.Location = new-object System.Drawing.Point(72, 7)
            $textbox1.Name = "textBoxMessage"
            $textbox1.Size = new-object System.Drawing.Size(100, 20)
            $textbox1.TabIndex = 0
    
            $l1 = New-Object System.Windows.Forms.Label
            $l1.Location = New-Object System.Drawing.Size(72,32)
            $l1.Size = New-Object System.Drawing.Size(400,300)
            $l1.Text = ''
    
            $l1.Font = new-object System.Drawing.Font('Microsoft Sans Serif', 8, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Point, 0);
	
	

	
	
	
	$panel2.Controls.Add($l1)
	
	########TAB 2
    

    ## quickview button -input file


    ##################
    # 
    $inputfilequickviwbutton.Location = new-object System.Drawing.Point(275, 150)
    $inputfilequickviwbutton.Name = "buttonShowMessage"
    $inputfilequickviwbutton.Size = new-object System.Drawing.Size(75, 22)
    $inputfilequickviwbutton.TabIndex = 0
    $inputfilequickviwbutton.Text = "quickview"
    $inputfilequickviwbutton_Click = {
        convertcsv
        Import-Csv -Path $env:temp\$date-tmpfupload.csv | Out-GridView -Title "Input file quickview" -PassThru | format-wide
        
               
    }
    $inputfilequickviwbutton.Add_Click($inputfilequickviwbutton_Click)
    $inputfilequickviwbutton.enabled = $false



	##################
	#     Choose Spreadhseet Button
	$choseinputfilebutton.Location = new-object System.Drawing.Point(7, 43)
	$choseinputfilebutton.Name = "buttonShowMessage"
	$choseinputfilebutton.Size = new-object System.Drawing.Size(127, 22)
	$choseinputfilebutton.TabIndex = 0
	$choseinputfilebutton.Text = "Choose Input file"
	$choseinputfilebutton_Click = {
	
		
		
        Get-FileName
       
        $textbox2.Text = $selectedfile
        convertcsv
        checkcreditdebit
		#[System.Windows.Forms.MessageBox]::Show($textbox2.Text);
	}
	$choseinputfilebutton.Add_Click($choseinputfilebutton_Click)
	
	
	
    
            $textbox2.Add_Leave( {
               param(
                [Object] $sender,
                [System.EventArgs] $eventargs
                )
                if ($sender.Text.length -eq "<--Select an Input File") {
                  $l1.Text = 'Input required'
                  # [System.Windows.Forms.MessageBox]::Show('Input required')
                  $tab_control1.SelectedIndex = 1
                  $sender.Select()
				$result = $sender.Focus()
				
                } else {
				$l1.Text = ''
				

				
			
                }







        })
    
    #################################################################
    #  Continue Ui code:
    #################################################################
	##where the tabs are added
            $tab_control1.Controls.Add($panel1)
            $tab_control1.Controls.Add($panel2)
	
	################## Tab Location and Size
	$tab_control1.Location = new-object System.Drawing.Point(7, 88)
            $tab_control1.Name = "tabControl1"
            $tab_control1.SelectedIndex = 1
            $textbox1.Select()
            $textbox1.Enabled = $true
            $tab_control1.Size = new-object System.Drawing.Size(367, 250)
            $tab_control1.TabIndex = 0
    
            $f.AutoScaleBaseSize = new-object System.Drawing.Size(5, 13)
	########  Window SIZE:
	
	$f.ClientSize = new-object System.Drawing.Size(680, 349)
            $f.Controls.Add($tab_control1)
            $panel2.ResumeLayout($false)
            $panel2.PerformLayout()
            $panel1.ResumeLayout($false)
            $tab_control1.ResumeLayout($false)
            $f.ResumeLayout($false)
            $f.ActiveControl = $textbox1
    
            $f.Topmost = $true
    
    
            $f.Add_Shown( { $f.Activate() } )
            $f.KeyPreview = $True
    
    
            [Void] $f.ShowDialog( ($caller) )
	
	$f.Dispose()


    }
    PromptWithTabs





    rv * -ea SilentlyContinue; rmo *; $error.Clear(); 

