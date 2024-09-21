# Anbennar_Extractor
It extracts the compiled zip from https://bitbucket.org/JayBean/anbennar-eu4-fork-public-build/downloads/?tab=downloads

This will also copy and rename the Anbennar-PublicFork.mod file and edit all the lines appropriately to match the provided output path name.

## Step 1
Download Anbennar_Extract.ps1

## Step 2
Move/copy to your EU4 mods folder (Default location is ~Documents\Paradox Interactive\Europa Universalis IV\mod)

## Step 3a
Run
```
    Set-ExecutionPolicy RemoteSigned
```
To enable the execution of signed powershell scripts

## Step 3b
Right click on Anbennar_Extract.ps1 to select "Run with PowerShell"  (you'll probably be prompted to trust my untrusted and self-signed "huff.systems Script Authenticator" script)

## Step 4
Click and drag JayBean-anbennar-eu4-fork-public-build-XXXXXXXXXXXX.zip into the PowerShell window

(optionally type or add -filePath "(file location)\JayBean-anbennar-eu4-fork-public-build-XXXXXXXXXXXX.zip" if you're feeling spicy) 

## Step 5
Click enter to accept the default .\Anbennar-PublicFork location, or specify your own.

(Spicy mode: add -path flag to script call)

## Step 6

Profit!
