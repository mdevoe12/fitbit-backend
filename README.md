# insight (api)

Insight is for Fitbit users who want to know more about their data. Currently, Fitbit does not have a consumer-facing app that correlates the myriad of data that their devices collect. While their app is certainly useful, insight is built for those who want to know more about what's going on. Insight's end goal is to empower users to look deeper, identify trends and find correlations.


Insight is built on two separate applications. This repo is for the React front-end, currently running live here: https://mdevoe12.github.io/fitbit-front-end-react/, the GitHub repo can be found here: https://github.com/mdevoe12/fitbit-front-end-react

The back-end is a Ruby-on-Rails server currently hosted on Heroku: https://insight-api.herokuapp.com/

## Getting Started

See below to get started.

### Prerequisites

Note: the core of insight's back-end is built using Ruby 2.4.1 and Ruby-on-Rails 5.1.4. To ensure you have these versions installed. Run the following in your terminal:

```
$ ruby -v
```

You should see a response similar to:

```
ruby 2.4.1p111
```

and if running

```
$ rails -v
```

response:

```
Rails 5.1.4
```

If neither are installed, the following tutorial is an excellent source to get you up and running on macOS:

http://railsapps.github.io/installrubyonrails-mac.html

### Installing

1) Fork and then clone this repository to your local machine

```
$ git clone git@github.com:mdevoe12/fitbit-backend.git
```

2) Change directories to the newly cloned down repo

```
$ cd fitbit-backend
```

3) Once in the directory, bundle:
   (this may take a bit of time)

```
$ bundle
```

4) Create the database (Postgres is used for insight):

```
$ rake db:create
```

5) Migrate the database:

```
$ rake db:migrate
```

6) The master branch of this repository is configured for production. To be able to run this current repository in development, you will need to do the following if you wish to connect a local(developer) copy of the React front end to this backend:

a) Open the repository in your preferred text editor
b) Global find and replace https://mdevoe12.github.io/fitbit-front-end-react/ with http://localhost:8080.


7) Because insight uses fitbit data, you will need to register for a Fitbit developer client_id and secret at https://dev.fitbit.com/apps/new

8) Upon obtaining those keys. You will need to create your .application.yml file to securely store those keys:
a) in your terminal:

```
bundle exec figaro install
```

This will create your the .application.yml - Create two new entries in the application.yml:
FITBIT_CLIENT_ID: {your new client_id goes here}
FITBIT_CLIENT_SECRET: {your new client_secret goes here}


9) To launch this application in development, run:

```
$ rails s
```

10) You will now be able to connect the front end to the back end. Note, if you do not have a Fitbit user account with which to authenticate, you will need to create a seed file in ./db/seeds.rb or manually create entries by typing this into your terminal:

```
$ rails c
```

## A note on data persistence

The account creation and login process occurs from the React front end. Upon clicking "Login", a user will be redirected to the Fitbit site for authorization.

Upon authorization, the user is either logged in (if a returning user) or an account is created and 30 days worth of data is persisted to the database.

You will then be redirected back to the front end, where you will see several charts rendering sleep, calorie expenditure and resting heart rate.

More to come soon.


## Endpoints in Use

```
get api/v1/keys
```

The React front end makes a secure call to the database to kick off the Oauth Process.

```
post auth/fitbit/callback
```

Callback for persisting user information to database.

```
get api/v1/fitbit_data
```

Endpoint that automatically renders JSON for use on the React Front End. Note, this uses web tokens to make secure api calls.

```
delete api/v1/logout
```

Logs the user out of the front end and destroys the authentication token used to make web calls.

## Built With

* [Ruby-on-Rails](http://rubyonrails.org/) - Back-end Framework
* [Ruby](https://www.ruby-lang.org/en/) - Ruby
* [FitBit](https://dev.fitbit.com/) - FitBit Web API

## Contributing

If you would like to contribute, please fork and clone this repo. After making your proposed changes, please submit a pull request to the original repository with mdevoe12 tagged in the PR.
