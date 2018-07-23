# Micro-Learning App
[![CircleCI](https://circleci.com/gh/maxcutex/microlearningapp.svg?style=svg)](https://circleci.com/gh/maxcutex/microlearningapp)
[![Coverage Status](https://coveralls.io/repos/github/Maxcutex/microlearningapp/badge.svg?branch=develop)](https://coveralls.io/github/Maxcutex/microlearningapp?branch=develop)

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

### Testing
Tests can be run using
```
bundle exec rspec
```