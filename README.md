# memeories
#### _remember your memes..._

... and learn Ember.js

#### Installation

1. `git clone https://github.com/tritowntim/memeories.git`
1. `cd memeories`
1. `Gemfile` is set to Ruby 2.1.2, **feel free to change to a version of Ruby already installed on your machine** to avoid Ruby install time
1. `bundle`
1. `rake db:reset`
1. `rspec`, all specs should pass
1. `rails s`
1. Install Ember Inspector dev tools addon for either [Chrome](https://chrome.google.com/webstore/detail/ember-inspector/bmdblncegkenkacieihfhpjfppoconhi?hl=en) or [Firefox](https://addons.mozilla.org/en-US/firefox/addon/ember-inspector/)

#### What's In Here

An API for creating, reading, updating, and deleting memes
  - [http://localhost:3000/api/v1/memes](http://localhost:3000/api/v1/memes)
    - Returns ten memes created by seed data
  - [http://localhost:3000/api/v1/memes/1](http://localhost:3000/api/v1/memes/1)
    - Returns individual memes

A blank home page for building an Ember app
  - [http://localhost:3000](http://localhost:3000)

#### Implementation

- This app uses the `ember-rails` gem, which depends upon the `active_model_serializers` gem for creating JSON APIs in the format necessary for Ember Data.
- `ember-rails` has [already been configured](https://github.com/tritowntim/memeories/blob/master/config/application.rb#L31) to create an Ember app name of `App` instead of the rails app name 
- Turbolinks has been disabled
- Coffeescript has been disabled

#### References
- [Ember-in-Rails tutorial](http://ember.vicramon.com/)
