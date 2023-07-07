# README

## Getting Started

1. Ensure you have all the correct system dependencies
    * Postgres
    * Those listed in "Guide Assumptions" here: https://guides.rubyonrails.org/v5.0/getting_started.html
1. Setup `.env.local`
    * Obtain an api key from https://www.weatherbit.io/
    * Create a `.env.local` file in the root directory
    * Enter the key as such: `WEATHER_BIT_KEY=<your key>`
1. Run `bundle`
1. Run `bin/setup`
1. Run `bin/dev`

## Running Tests

* run tests with `bundle exec rspec`

## TODO

* Pin dependencies to specific versions
* Write tests for hiding/showing delete button and charts