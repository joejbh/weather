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

## Notes

* I believe in only exposing endpoints that have a legitimate business need for security reasons. This is why I removed
  the ability to fetch the data via json and I also removed the show endpoints.

## TODOs

* Pin dependencies to specific versions
* Write tests for hiding/showing delete button and charts
* Handle errors from https services better
* Handle transient failures
* Make deployment pipeline
* Make automated browser tests
* Pagination
* Show more forecast details
* Cache fetched forecasts for one day