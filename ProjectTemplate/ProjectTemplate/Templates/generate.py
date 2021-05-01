# Using: python3 <path>/template_clone_script.py <name of module> <path to place module will be copy to>
# Ex: python3 template_clone_script.py  new_login lib/modules
# Must input two aruguments: first is the name of module, the second is the path that will store module
# Command python3 or python is up to OS (Mac use python3 to specify python version 3)
# Current folder in command NEED TO BE  the fodler which contain script (is inside this project )
###
###
###

import sys
import os
from os import path
import io
from distutils.dir_util import copy_tree

# Define
currentPath = os.getcwd()
sourceFolderName = "/rx-swift"
textNeedToReplace = "Template__"
nameOfFileScreen = "ViewController.swift"
nameOfFileScreenLayout = "ViewController.xib"
nameOfFileViewModel = "ViewModel.swift"
nameOfFileRepo = "Repository.swift"
nameOfFileLocalNavigator = "LocalNavigator.swift"
nameOfFileFactory = "Factory.swift"


def fileNameToClassName(filename):
    filename = filename.replace("_", " ")
    filename = filename.title()
    filename = filename.replace(" ", "")
    return filename


# Command input arguments
if len(sys.argv) < 3:
    print("Error: Must input name of module and folder path")
    exit(1)

targetName = sys.argv[1]
targetFolder = sys.argv[2]

if len(targetName) <= 0 or len(targetFolder) <= 0:
    print("Error: Must input name of module and folder path")
    exit(1)

# Check if target folder exist
source = currentPath + sourceFolderName
destination =  targetFolder + "/" + targetName
if path.exists(destination):
    print("Error: The folder " + destination + " already exist")
    exit(1)


print("Start generate module " + targetName + " at " + targetFolder)

# Copy whole mvvm_template folder to destination
copy_tree(source, destination)

# Change name and text of file screen
screenFilePath = destination + "/" + nameOfFileScreen
screenFilePathNewName = destination + "/" + targetName + "ViewController.swift"
with open(screenFilePath, "r+") as screenFile:
    data = screenFile.read().replace(textNeedToReplace, fileNameToClassName(
        targetName)) #.replace(nameOfFileViewModel, targetName + "ViewModel.swift")
    screenFile.seek(0)
    screenFile.write(data)
    screenFile.truncate()
os.rename(screenFilePath, screenFilePathNewName)

# layout file
screenFilePath = destination + "/" + nameOfFileScreenLayout
screenFilePathNewName = destination + "/" + targetName + "ViewController.xib"
with open(screenFilePath, "r+") as screenFile:
    data = screenFile.read().replace(textNeedToReplace + "ViewController", targetName + "ViewController")
    screenFile.seek(0)
    screenFile.write(data)
    screenFile.truncate()
os.rename(screenFilePath, screenFilePathNewName)


# Change name and text of file view_model
viewModelFilePath = destination + "/" + nameOfFileViewModel
viewModelFilePathNewName = destination + "/" + targetName + "ViewModel.swift"
with open(viewModelFilePath, "r+") as viewModelFile:
    data = viewModelFile.read().replace(
        textNeedToReplace, fileNameToClassName(targetName)) #.replace(nameOfFileRepo, targetName + "_repository.dart")
    viewModelFile.seek(0)
    viewModelFile.write(data)
    viewModelFile.truncate()
os.rename(viewModelFilePath, viewModelFilePathNewName)

# Change name and text of file repository
repositoryFilePath = destination + "/" + nameOfFileRepo
repositoryFilePathNewName = destination + "/" + targetName + "Repository.swift"
with open(repositoryFilePath, "r+") as repositoryFile:
    data = repositoryFile.read().replace(
        textNeedToReplace, fileNameToClassName(targetName))
    repositoryFile.seek(0)
    repositoryFile.write(data)
    repositoryFile.truncate()
os.rename(repositoryFilePath, repositoryFilePathNewName)

# Change name and text of file navigator
repositoryFilePath = destination + "/" + nameOfFileLocalNavigator
repositoryFilePathNewName = destination + "/" + targetName + "LocalNavigator.swift"
with open(repositoryFilePath, "r+") as repositoryFile:
    data = repositoryFile.read().replace(
        textNeedToReplace, fileNameToClassName(targetName))
    repositoryFile.seek(0)
    repositoryFile.write(data)
    repositoryFile.truncate()
os.rename(repositoryFilePath, repositoryFilePathNewName)

# Change name and text of file factory
repositoryFilePath = destination + "/" + nameOfFileFactory
repositoryFilePathNewName = destination + "/" + targetName + "Factory.swift"
with open(repositoryFilePath, "r+") as repositoryFile:
    data = repositoryFile.read().replace(
        textNeedToReplace, fileNameToClassName(targetName))
    repositoryFile.seek(0)
    repositoryFile.write(data)
    repositoryFile.truncate()
os.rename(repositoryFilePath, repositoryFilePathNewName)