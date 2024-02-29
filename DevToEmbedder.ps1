######################################################################################
# DevToEmbedder V1.0 - Released 01/03/2024                                           #
#                                                                                    #
# Script Created by ReproDev:   https://github.com/reprodev/DevToEmbedder            #
# Released Under MIT Licence                                                         # 
# Check out other projects :    https://github.com/reprodev/                         #
# Why not buy me a coffee? :    https://ko-fi.com/reprodev                           #
#                                                                                    #
######################################################################################

# Call the GUI elements
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Minimize the PowerShell console window
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class ConsoleWindow {
        [DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        public static void Minimize() {
            IntPtr consoleWindow = System.Diagnostics.Process.GetCurrentProcess().MainWindowHandle;
            const int SW_MINIMIZE = 6;
            ShowWindow(consoleWindow, SW_MINIMIZE);
        }
    }
"@

# Call the Minimize method to minimize the console window
[ConsoleWindow]::Minimize()

# Setup the form window
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'DevToEmbedder'
$form.Size = New-Object System.Drawing.Size(400,245)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog' # Prevent resizing
$form.MaximizeBox = $false # Disable maximize button

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Paste the link you want to embed on your DevTo Blog'
$form.Controls.Add($label)

# Supported List Button
$supportedButton = New-Object System.Windows.Forms.Button
$supportedButton.Location = New-Object System.Drawing.Point(207,175)
$supportedButton.Size = New-Object System.Drawing.Size(95,23)
$supportedButton.Text = 'Supported Sites'
$form.Controls.Add($supportedButton)

$inputTextbox = New-Object System.Windows.Forms.TextBox
$inputTextbox.Location = New-Object System.Drawing.Point(10,30)
$inputTextbox.Size = New-Object System.Drawing.Size(360,20)
$form.Controls.Add($inputTextbox)

$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10,60)
$button.Size = New-Object System.Drawing.Size(200,23)
$button.Text = 'Convert into DevTo Embed link'
$form.Controls.Add($button)

$outputTextbox = New-Object System.Windows.Forms.TextBox
$outputTextbox.Location = New-Object System.Drawing.Point(10,90)
$outputTextbox.Size = New-Object System.Drawing.Size(360,80)
$outputTextbox.Multiline = $true
$outputTextbox.ScrollBars = 'Vertical'
$outputTextbox.ReadOnly = $true
$form.Controls.Add($outputTextbox)

$copyButton = New-Object System.Windows.Forms.Button
$copyButton.Location = New-Object System.Drawing.Point(10,175)
$copyButton.Size = New-Object System.Drawing.Size(90,23)
$copyButton.Text = 'Copy HTML'
$form.Controls.Add($copyButton)

# Clear Button
$clearButton = New-Object System.Windows.Forms.Button
$clearButton.Location = New-Object System.Drawing.Point(110,175)
$clearButton.Size = New-Object System.Drawing.Size(90,23)
$clearButton.Text = 'Clear'
$form.Controls.Add($clearButton)

# About Button
$aboutButton = New-Object System.Windows.Forms.Button
$aboutButton.Location = New-Object System.Drawing.Point(310,175)
$aboutButton.Size = New-Object System.Drawing.Size(60,23)
$aboutButton.Text = 'About'
$form.Controls.Add($aboutButton)

$generateHtmlAction = {
    $GiphyAdd = $inputTextbox.Text
    $html = "{% embed $($GiphyAdd)%}"
    $outputTextbox.Text = $html
}

$button.Add_Click($generateHtmlAction)

$copyButton.Add_Click({
    [System.Windows.Forms.Clipboard]::SetText($outputTextbox.Text)
})

$clearButton.Add_Click({
    $inputTextbox.Clear()
    $outputTextbox.Clear()
})

$supportedAction = {
    $message = "- DEV Community Comment`n" +
               "- DEV Community Link`n" +
               "- DEV Community Link`n" +
               "- DEV Community Listing`n" +
               "- DEV Community Organization`n" +
               "- DEV Community Podcast Episode`n" +
               "- DEV Community Tag`n" +
               "- DEV Community User Profile`n" +
               "- asciinema`n" +
               "- CodePen`n" +
               "- CodeSandbox`n" +
               "- DotNetFiddle`n" +
               "- GitHub Gist, Issue or Repository`n" +
               "- Glitch`n" +
               "- Instagram`n" +
               "- JSFiddle`n" +
               "- JSitor`n" +
               "- Loom`n" +
               "- Kotlin`n" +
               "- Medium`n" +
               "- Next Tech`n" +
               "- Reddit`n" +
               "- Replit`n" +
               "- Slideshare`n" +
               "- Speaker Deck`n" +
               "- SoundCloud`n" +
               "- Spotify`n" +
               "- StackBlitz`n" +
               "- Stackery`n" +
               "- Stack Exchange or Stack Overflow`n" +
               "- Twitch`n" +
               "- Twitter`n" +
               "- Twitter timeline`n" +
               "- Wikipedia`n" +
               "- Vimeo`n" +
               "- YouTube"
    [System.Windows.Forms.MessageBox]::Show($message, "DevToEmbedder Supported Sites")
}

$supportedButton.Add_Click($supportedAction)

$aboutAction = {
    $aboutForm = New-Object System.Windows.Forms.Form
    $aboutForm.Size = New-Object System.Drawing.Size(270,200)
    $aboutForm.StartPosition = 'CenterScreen'
    $aboutForm.Text = 'About'
    $aboutform.FormBorderStyle = 'FixedDialog'
    $aboutform.MaximizeBox = $false
    $aboutform.MinimizeBox = $false

    $aboutLabel = New-Object System.Windows.Forms.Label
    $aboutLabel.Location = New-Object System.Drawing.Point(10,10)
    $aboutLabel.Size = New-Object System.Drawing.Size(280,120)
    $aboutLabel.Text = "DevToEmbedder`n" +
                       "`n" +
                       "Version: 1.0a`n" +
                       "`n" +
                       #"Release Date: 2024-03-01`n" +
                       "Developed by: ReproDev`n" +
                       "`n" +
                       "Contact: info@reprodev.com`n" +
                       "`n" +
                       "For updates and more projects visit my GitHub"
    $aboutForm.Controls.Add($aboutLabel)

    $linkLabel = New-Object System.Windows.Forms.LinkLabel
    $linkLabel.Location = New-Object System.Drawing.Point(10,128)
    $linkLabel.Size = New-Object System.Drawing.Size(280,80)
    $linkLabel.Text = 'https://github.com/reprodev/'

    # Clear existing links to prevent overlap error
    $linkLabel.Links.Clear()
    
    # Now add the link
    $linkLabel.LinkArea = New-Object System.Windows.Forms.LinkArea(0, $linkLabel.Text.Length)
    $linkLabel.Links.Add(0, $linkLabel.Text.Length, 'https://github.com/reprodev/') # Link data

    $linkLabel.Add_LinkClicked({
        param($sender, $e)
        Start-Process $e.Link.LinkData
    })

    $aboutForm.Controls.Add($linkLabel)
    $aboutForm.ShowDialog()
}


$aboutButton.Add_Click($aboutAction)

$inputTextbox.Add_KeyDown({
    param($sender, $e)
    if ($e.KeyCode -eq 'Return') {
        $generateHtmlAction.Invoke()
    }
})

$form.ShowDialog()
