Pashost KMS - Windows Activation Script
This script allows users to activate Windows 10 or Windows 11 by choosing either the Pro or Home edition and applying a Key Management Service (KMS) activation key. It provides an automated method to enter the correct product key and connect to a KMS server, which can activate Windows in environments where KMS is supported.

Disclaimer: This script is intended for educational purposes only. Activating Windows with KMS requires a valid licensing agreement with Microsoft. Unauthorized use of KMS keys to activate Windows without a proper license may violate Microsoft’s licensing terms.

Features
Automatically prompts the user to select the Windows version to activate (Pro or Home).
Checks if the script is running with administrator privileges, and attempts to re-launch itself with elevated privileges if not.
Checks the activation status to avoid re-activating if Windows is already activated.
Suppresses output messages from Windows Script Host to keep the process silent.
Runs all commands in a clean, user-friendly manner without unnecessary prompts or dialogs.
How It Works
Administrator Check: Ensures that the script is run with administrator privileges. If not, it re-launches itself with the required permissions.
User Prompt: Prompts the user to choose between Windows 10/11 Pro or Home.
Activation Key Selection: Sets the KMS activation key based on the user’s selection.
Activation Status Check: Checks if Windows is already activated and skips activation if it is.
Silent Activation Process: Runs commands to set the product key, configure the KMS server, and activate Windows, all while suppressing output messages.
Usage
Download or Clone the Repository

bash
Copy code
git clone https://github.com/Pashost/Pashost_KMS.git
Run the Script

Open the Command Prompt as Administrator.
Run the script by navigating to the script’s directory and entering:
cmd
Copy code
WindowsActivationScript.bat
Follow the Prompt

When prompted, enter the number corresponding to your Windows version:
1 for Windows 10/11 Pro
2 for Windows 10/11 Home
Wait for Activation to Complete

The script will attempt to activate Windows silently. If successful, it will display a success message in the Command Prompt and then exit.
Example
plaintext
Copy code
Please select the version to activate:
1. Windows 10/11 Pro
2. Windows 10/11 Home
Enter the number of your choice (1 or 2):
Important Notes
KMS Activation Requirements: KMS activation is generally used by organizations with volume licensing agreements. This script will only work in environments where KMS activation is allowed, such as with a legitimate KMS server.
Internet Connection Required: An active internet connection may be necessary for activation.
Administrator Privileges Required: This script requires administrator privileges to modify the system’s activation status.
Suppressing Windows Script Host Dialogs: The script suppresses dialogs that would normally pop up during activation, providing a more seamless experience.
Troubleshooting
Script Fails to Run with Administrator Privileges: Ensure that you run the script as Administrator. If you’re unable to elevate the script, try temporarily disabling User Account Control (UAC).
Windows Not Activating: This script relies on a KMS server for activation. Ensure you have network access to the KMS server and that it’s configured correctly.
Anti-Virus Software: Some anti-virus programs may flag or block activation scripts. If you encounter issues, try adding an exception for this script.
Warnings
Licensing Agreement: Make sure you are in compliance with Microsoft’s licensing terms before using this script.
Education and Testing Purposes Only: This script is intended for educational purposes and testing in legitimate environments where KMS activation is permitted.
Contributing
Feel free to contribute to this repository by creating pull requests for improvements or reporting issues in the issue tracker.

Acknowledgments
This script was inspired by the need to automate Windows activation in KMS-supported environments and is based on publicly available information about KMS activation methods. We thank the open-source community for their contributions to similar projects.
