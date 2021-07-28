<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
    .INSTRUCTIONS
        1- Change line 95 to your email domain/domain for users
        2- Change line 204 to the list of email address you want available for users
        3- Change Splatting Array on line 212 to fit your environment
        4- Change line 172 to reflect a UNC path in your $ENV if you want to
#>
Function RequestHelp {

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    # Add Validation Control
    $ErrorProvider = New-Object System.Windows.Forms.ErrorProvider


    $SubmitRemoteAssist              = New-Object system.Windows.Forms.Form
    $SubmitRemoteAssist.ClientSize   = New-Object System.Drawing.Point(324,272)
    $SubmitRemoteAssist.text         = "Remote Assistance Request"
    $SubmitRemoteAssist.TopMost      = $true
    $SubmitRemoteAssist.Icon         = [system.drawing.icon]::ExtractAssociatedIcon("$ENV:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe")

    $SuppPwd                         = New-Object system.Windows.Forms.MaskedTextBox
    $SuppPwd.multiline               = $false
    $SuppPwd.PasswordChar            = '*'
    $SuppPwd.width                   = 145
    $SuppPwd.height                  = 20
    $SuppPwd.location                = New-Object System.Drawing.Point(155,121)
    $SuppPwd.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $SuppPwdLbl                      = New-Object system.Windows.Forms.Label
    $SuppPwdLbl.text                 = "Support Password :"
    $SuppPwdLbl.AutoSize             = $true
    $SuppPwdLbl.width                = 25
    $SuppPwdLbl.height               = 10
    $SuppPwdLbl.location             = New-Object System.Drawing.Point(8,121)
    $SuppPwdLbl.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

    $GetHelpBtn                      = New-Object system.Windows.Forms.Button
    $GetHelpBtn.text                 = "Get Help!"
    $GetHelpBtn.width                = 92
    $GetHelpBtn.height               = 30
    $GetHelpBtn.location             = New-Object System.Drawing.Point(24,217)
    $GetHelpBtn.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $GetHelpBtn.Enabled              = $false
    #Enables the Get Support Button if SuppPWD is correct
    $SuppPwd.add_TextChanged({ValidatePassword})
    function ValidatePassword{
	        if ($SuppPwd.Text.Length -lt 6)
	        {
		        $GetHelpBtn.Enabled = $false
	        }
	        else
	        {
		        $GetHelpBtn.Enabled = $True
                $ErrorProvider.Clear()
	        }
        }
    If ($SuppPWD.Text.Length -le 6) {$ErrorProvider.SetError($SuppPWD, "Support Password must be longer than 6 characters")} 

    $QuitBtn                         = New-Object System.Windows.Forms.Button
    $QuitBtn.text                    = "Quit"
    $QuitBtn.width                   = 86
    $QuitBtn.height                  = 30
    $QuitBtn.location                = New-Object System.Drawing.Point(162,217)
    $QuitBtn.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $UsernameBx                      = New-Object system.Windows.Forms.TextBox
    $UsernameBx.multiline            = $false
    $UsernameBx.Text                 = $env:USERNAME
    $usernameBx.ReadOnly             = $true
    $UsernameBx.width                = 145
    $UsernameBx.height               = 20
    $UsernameBx.location             = New-Object System.Drawing.Point(155,20)
    $UsernameBx.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $UsernameLbl                     = New-Object system.Windows.Forms.Label
    $UsernameLbl.text                = "Username :"
    $UsernameLbl.AutoSize            = $true
    $UsernameLbl.width               = 25
    $UsernameLbl.height              = 10
    $UsernameLbl.location            = New-Object System.Drawing.Point(24,21)
    $UsernameLbl.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

    $EmailLbl                        = New-Object system.Windows.Forms.Label
    $EmailLbl.text                   = "Email Address :"
    $EmailLbl.AutoSize               = $true
    $EmailLbl.width                  = 25
    $EmailLbl.height                 = 10
    $EmailLbl.location               = New-Object System.Drawing.Point(18,54)
    $EmailLbl.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

    $EmailBx                         = New-Object system.Windows.Forms.TextBox
    $EmailBx.multiline               = $false
    $EmailBx.Text                    = "$($env:USERNAME)@domain.org"
    $EmailBx.ReadOnly                = $true
    $EmailBx.width                   = 145
    $EmailBx.height                  = 20
    $EmailBx.location                = New-Object System.Drawing.Point(155,54)
    $EmailBx.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $CmpNmLbl                        = New-Object system.Windows.Forms.TextBox
    $CmpNmLbl.multiline              = $false
    $CmpNmLbl.Text                   = $env:COMPUTERNAME
    $CmpNmLbl.ReadOnly               = $true
    $CmpNmLbl.width                  = 145
    $CmpNmLbl.height                 = 20
    $CmpNmLbl.location               = New-Object System.Drawing.Point(155,87)
    $CmpNmLbl.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $ComputerNameLbl                 = New-Object system.Windows.Forms.Label
    $ComputerNameLbl.text            = "Computer Name :"
    $ComputerNameLbl.AutoSize        = $true
    $ComputerNameLbl.width           = 25
    $ComputerNameLbl.height          = 10
    $ComputerNameLbl.location        = New-Object System.Drawing.Point(13,87)
    $ComputerNameLbl.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

    $EmailCheck                      = New-Object system.Windows.Forms.CheckBox
    $EmailCheck.text                 = "Email Request"
    $EmailCheck.AutoSize             = $false
    $EmailCheck.width                = 135
    $EmailCheck.height               = 20
    $EmailCheck.location             = New-Object System.Drawing.Point(18,162)
    $EmailCheck.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

    $CopyRequest                     = New-Object system.Windows.Forms.CheckBox
    $CopyRequest.text                = "UNC Copy"
    $CopyRequest.AutoSize            = $false
    $CopyRequest.width               = 95
    $CopyRequest.height              = 20
    $CopyRequest.location            = New-Object System.Drawing.Point(161,162)
    $CopyRequest.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))



    $SubmitRemoteAssist.controls.AddRange(@($GetHelpBtn,$QuitBtn,$UsernameBx,$UsernameLbl,$EmailLbl,$EmailBx,$CmpNmLbl,$ComputerNameLbl,$SuppPwd,$SuppPwdLbl,$EmailCheck,$CopyRequest))
    
    $SupportDate = Get-Date -Format 'MM-dd-yyyy-hh-mm-sstt'

    $SupportFileLocation = "$($env:USERPROFILE)\Desktop\$($SupportDate)_$($ENV:ComputerName)_$($ENV:Username)"

    $SupportDirectory = [System.Environment]::SystemDirectory

    $SupportFile = "$($SupportDirectory)\msra.exe"

    $GetHelpBtn.Add_Click({  


    $SupportMSRA = Start-Process -FilePath $SupportFile -ArgumentList "/saveasfile $SupportFileLocation $($SuppPwd.Text)" -WindowStyle Normal -PassThru
    if ($EmailCheck.Checked) {
        Start-Sleep -s 15
        RequestEmail
        }
    If ($CopyRequest.Checked ) {
        Start-Sleep -s 15
        RequestCopy
    }
    [void]$SubmitRemoteAssist.Close()
    })
    
    $QuitBtn.Add_Click({  
    [void]$SubmitRemoteAssist.Close()
    })

    #Shows the form
[void]$SubmitRemoteAssist.ShowDialog()
[void]$SubmitRemoteAssist.Activate()
}

Function RequestCopy {
    Copy-Item -Path "$SupportFileLocation.msrcincident" -Destination "\\some\unc\file\share\path\that\users\and\IT\have\access\to\$($ENV:USERNAME)-$($ENV:COMPUTERNAME)-$($SupportDate).msrcincident"
    Remove-Item "$SupportFileLocation.msrcincident" -Force
}

Function RequestEmail {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $EmailSuppOptions                 = New-Object system.Windows.Forms.Form
    $EmailSuppOptions.ClientSize      = New-Object System.Drawing.Point(355,111)
    $EmailSuppOptions.text            = "Choose Technican"
    $EmailSuppOptions.TopMost         = $true
    $EmailSuppOptions.Icon            = [system.drawing.icon]::ExtractAssociatedIcon("$ENV:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe")


    $ITWorkerBtn                     = New-Object system.Windows.Forms.Button
    $ITWorkerBtn.text                = "OK"
    $ITWorkerBtn.width               = 103
    $ITWorkerBtn.height              = 30
    $ITWorkerBtn.location            = New-Object System.Drawing.Point(123,64)
    $ITWorkerBtn.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

    $ITWorkerLbl                     = New-Object system.Windows.Forms.Label
    $ITWorkerLbl.text                = "IT Worker :"
    $ITWorkerLbl.AutoSize            = $true
    $ITWorkerLbl.width               = 25
    $ITWorkerLbl.height              = 10
    $ITWorkerLbl.location            = New-Object System.Drawing.Point(15,23)
    $ITWorkerLbl.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

    $ITWorkerChoice                  = New-Object system.Windows.Forms.ComboBox
    $ITWorkerChoice.text             = "Select IT Worker Email"
    $ITWorkerChoice.width            = 217
    $ITWorkerChoice.height           = 20
    @('email@domain.org','email@domain.com') | ForEach-Object {[void] $ITWorkerChoice.Items.Add($_)}
    $ITWorkerChoice.location         = New-Object System.Drawing.Point(109,22)
    $ITWorkerChoice.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $EmailSuppOptions.controls.AddRange(@($ITWorkerBtn,$ITWorkerLbl,$ITWorkerChoice))

    ########################
    # Send Email
    $ITWorkerMail = @{
        SMTPServer   = 'SMTPServer'
        From         = 'FROM'
        Subject      = "$($env:USERNAME) : $($ENV:ComputerName) : MSRA Request"
        Attachments  = "$SupportFileLocation.msrcincident"
        Priority     = 'High'
        Body         = "Support Password = $($SuppPwd.Text)"
    }

    $ITWorkerBtn.Add_Click({  
    ########################
    # Send Email
    Send-MailMessage @ITWorkerMail -To $ITWorkerChoice.SelectedItem
    Remove-Item -Path "$SupportFileLocation.msrcincident"
    [void]$EmailSuppOptions.Close()
    [void]$SubmitRemoteAssist.Close()
    })

    [void]$EmailSuppOptions.ShowDialog()
    [void]$EmailSuppOptions.Activate()

}

RequestHelp
