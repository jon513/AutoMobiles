some notes:
"reqruitement" spelled wrong on the readme file is not a good first impression.
it is hard to judge without seeing what the expectations were but it seems like it is over engerineered but not note done well.

Why is the network layer so large are complex? was the part of the requriment?

Wkda appear thoughtout the app and I have no idea what it means.  If it is some global idea to the project maybe it should be in the readme.

Also the View-Models and the View are not tightly coupled in the way I'd expect.  I'd expect the viewmodels to have exact the exact field that the view needs, but it doens't look.

Why is the ManufacturerTableViewCell set with a Wkda and not a viewmodel?

why does Manufacturers have a page and pagesize? do they manufacture pages?  this seems related to the network layer.  and then it has a wdka array - is that where all the acutal info is?

why does ManufacturerViewModelProtocol CarsViewModelProtocol exsit?  why can't you just use ViewModelsProtocol?

Overall I don't understand why the network layer is doing so much boilderplate stuff and why the model aren't actually extracting usful fields and organzing it in a useful way.


# Auto1 Sample Project


This sample project is for Auto1 reqruitement process.
This project arcitecture is multi-layered based on MVVM. 

> This project is using Auto1 sample json files


Layers are:
- Networking
- View Models 
- Views
- View
- Helpers and supporting files
- Application Delegate

# Libraries

- ObjectMapper to map json files to models
- SweaftyBeaver for log manager

# Unit Test

There are some unit tests for networking and view models

# Git

I use git and git flow mostly for my projects.


Thank you for reading this and I hope I get **Feedback** from you.
