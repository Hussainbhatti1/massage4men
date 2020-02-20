# README

This documentation describes how to set up the application, its components, how
to deploy it, and some internal information.

## Set up
This application needs ruby version 2.3.0.

This application is also based on the latest stable Rails version, which is, at
this moment, 4.2.9.

First, you have to install all the dependencies. To do so, run:

    gem install bundler
    bundle install


## Database creation, initialization

 Rename database.example.yml to database.yml and fill in the required details
 run -> rake db:create
 You can either import the dump or run migrations and seeds.

## Sphinx installation
	For linux:
		sudo apt-get install searchd --mysql --pgsql
	For MacOS
		brew install searchd --mysql --pgsql
	rake ts:index
	rake ts:rebuild

After that, your application is ready to go. To run it, you have to execute:

    rails s