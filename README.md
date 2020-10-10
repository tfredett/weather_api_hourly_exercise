# Weather Api Hourly Exercise

This is the API automation coding exercise for SignalPath, to demonstrate my ability to do the following.

* Start up a basic API automation framework
* Utilize said framework to write working automation
* Show coding style and structure

## Prerequisites
* Install [rbenv](https://github.com/rbenv/rbenv) with [ruby-build](https://github.com/rbenv/ruby-build)

## Install
4. Run `rbenv install`
5. Run `gem install bundler`
6. Run `bundle install`


## Running
* When ready, from a terminal simply run the `bundle exec cucumber` from the root of this repository.
 

# Repository Overiew

## Technologies Used
This makes use of the REST client tool known as [rest-client](https://github.com/rest-client/rest-client), as well as [Cucumber](https://cucumber.io/) and [RSpec](https://rspec.info/)

## Overall Structure
This project makes use of the page object model to organize concerns into areas that are more maintainable based on sections of the application under test. Since this is for API's, the actual page objects directory has been renamed to `endpoints`. The goal of these would would be to help describe and maintain construction of various requests to endpoints, that are easily reproducable, and reusable.

### Features
This is where the tests are described in terms of the actions and consequences expected by what we are simulating on behalf of a real user. For now, it is just a features folder, as this expands though, further directories within that directory for organizational purposes can be completed.

### Step Definitions
This is where the glue code connects the Gherkin found in the feature files, to the code being executed. This is also where the endpoint objects are used in order to create the requests, as well as validate the responses. This is done to provide a way that is easy to parse for a user, even if they do not know anything about the framework or programming in general. This is also done to help make the creation of requests, and the validation of the responses more consistent.

### Endpoint Objects
This is where we describe the expected types of components on a page, as well as the type of actions we can perform on that page. Utilizing endpoint objects, help reduces code duplication as well as help keep intact the Single Responsibility Principle. Since the page object would be the singular source of truth of what that page represents and what can be done on it.

### Helper Files
These are where various helper classes and methods would go. This is also where files can be organized and stored that has various helper methods. As an example, this has `compare_utils.rb` currently in it, with a helper method to determine if a value is a boolean or not. Since Ruby does not natively have a boolean, and instead as `TrueClass` and `FalseClass`.


### Known Places for Improvement
* The `features` folder should have subdirectories created for the various features that are there. In this case, one would be made, simply for the todo list page.
* Due to the limited scope in this area, this one is less crucial. As the project would grow though, doing a full directory glob require may be helpful to avoid the massive amounts of `require` and `require_relative` that would inevitibly begin to happen. An example of what I mean can be found [here](https://stackoverflow.com/a/4528011).
