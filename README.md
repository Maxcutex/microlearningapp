# Micro-Learning App
[![CircleCI](https://circleci.com/gh/Maxcutex/microlearningapp/tree/develop.svg?style=svg)](https://circleci.com/gh/Maxcutex/microlearningapp/tree/develop)
[![Coverage Status](https://coveralls.io/repos/github/Maxcutex/microlearningapp/badge.svg?branch=develop)](https://coveralls.io/github/Maxcutex/microlearningapp?branch=develop)
[![Maintainability](https://api.codeclimate.com/v1/badges/2f782861537bdec6b229/maintainability)](https://codeclimate.com/github/Maxcutex/microlearningapp/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/2f782861537bdec6b229/test_coverage)](https://codeclimate.com/github/Maxcutex/microlearningapp/test_coverage)


Micro-Learning App is a responsive web application that sends you one or multiple pages per day about things you want to learn.

https://rubymicrolearningapp.herokuapp.com/

The application provides a user with a choice of specifying interests and through this, appropriate pages are found and sent via the user's email.

## Usage
Using  [Ruby Version Manager](https://rvm.io/rvm/install) download and install the latest version of ruby, which can be downloaded from [here](https://www.ruby-lang.org/en/downloads/).

The application is built with [sinatra Web Framework](http://sinatrarb.com/) 

To clone the respository execute the following command.
```
git clone https://github.com/maxcutex/microlearningapp.git
```

Execute the following code to install all the application dependencies.
```
bundle install
```

Execute the following at the command line
```
rackup
```

Browse the application in the url
```
http://localhost:8282
```

### Features of Micro-Learning
- Signup with username, email and password
- Login with email and password
- View courses to learn
- Add courses to learn
- Daily resource provided for each topic by email
- Add courses by instructor
- Add course details by instructor
- Delete and edit courses and courses' details by instructor
- Add/edit and disable instructors by admin
- Add/edit and disable categories of courses by admin

### Installation Guide
- Install Ruby here and install it.
- Install RVM(Ruby Version Manager)
- Clone this repository with "git clone https://github.com/maxcutex/microlearningapp.git"
- run `bundle install` to install the dependencies.
- Navigate into the cloned project directory.
- Edit the `env-sample` file with your gmail creadentials and save it as `.env`
- run `rackup`
- Navigate to `localhost:9292`

### Testing
Tests can be run using
```
bundle exec rspec
```