# Architecture


## General

These are general guidelines that shows you how the project is structured and how you should create and organise the files .


## Base Architecture

#### File and Folder Structuring

These are the groups that the project has currently. You can create more groups if it's needed. Make sure to put it in an appropriate place. 

- Extensions
- Code
	* Controllers
	* Features
 	     -> Models
	     -> Services
	     -> Support Shapes
	     -> Support Views
	     -> Views 
- Utils
- Resources
	-> Fonts
	-> Other Assets


Put everything related to the project inside the **Code** group. Code or files that can be reused in other projects, can be put into **Extensions** / **Utils** / or a **New group**.


### Extensions

 Create Swift files and put extensions belonging to a particular struct / class in a single file.

> FoundationExtensions contains extensions to Double and Int structs.
> ColorExtensions  


### Code 

#### Controllers

Put Swift files that contains the core logic for the project in this group. If you plan to add navigation / routing logic or anything core, please do it here.
> Currently the app only contains the @main app file. 


**Feature** contains - 
		
*  Models		
	> Put models local to a Module in this group.
* Services
	> Put Swift files like ViewModels, Data fetchers / Defaults manager that can be used by Views to fetch/store data in this group.
* Support Shapes
	> Put shapes local to a Module in this group
* Support Views
	> Put subviews and smaller views local to a Module in this group.
* Views
	> Views contains the UI
