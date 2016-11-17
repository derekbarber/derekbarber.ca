---
layout: post
title: "Building a Rails API with JSON API (Part 1)"
date: 2015-08-29 16:57
comments: true
sharing: true
published: false
categories: [rails, api, rspec]
---

One of the current trends in web application development is the rise of the API-centric architecture. 
Rather than building a single monolitic application, you instead break out the server component 
into an API service and then you build out the front end as a consumer of that API. 

This has been spurred on by the incredible rise of mobile devices which in turn may also need their 
own native applications which then can become additional consumers of your API. The web front-end 
ultimately just becomes another client of your API along with any native mobile applications and
any third party consumers.

One of the primary difficulties around building an API is figuring out how to best structure your
responses: how to handle relationships between resources, sorting, pagination and a host of other
issues. Well, prior to JSON API you were left to figure all that out on your own, but now if you build
your API using the JSON API specification, you can instead rely upon it's tried and tested set of
conventions.

Additionally, with JSON API you can leverage both client and server implementations which make
the job of connecting the two components even more seamless. In this article I will be exploring the 
use of one such library, [JSONAPI::Resources](https://github.com/cerebris/jsonapi-resources), 
which a framework for developing a JSON API complicant Rails server.

In this first part we will create a new Rails application, hook up the JSONAPI::Resources gem
and then use Rspec to begin test-driving our API.

<!-- more -->

To start off, let's issue the **rails new** command to create a new rails application, and I'll be 
using some of my preferred defaults, such as using postgres as the database. (Rails 5 will make this
even easier by adding the "--api" option.)

```console
rails new app_name -d postgresql --skip-javascript --skip-test-unit
```

Next, add both the jsonapi-resources and rspec-rails gems to your Gemfile:

```ruby
gem 'jsonapi-resources'

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end
```

Then you can run bundle install to install the specified gems:

```console
bundle install
```

Install Rspec

```console
rails generate rspec:install
```console

Add API Inflection

```ruby
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'API'
end
```


Edit config/environments/development.rb

Eager loading of classes is recommended. The code will work without it, but 
I think it's the right way to go. Also, turn off consider_all_request_local. 
This will prevent the server from returning the HTML formatted error messages 
when an exception happens.

```ruby
config.eager_load = true

config.consider_all_requests_local       = false
```


## Add Auction Model

```console
rails generate model Auction
```


## Add Auctions Model



## Setup RSpec

Add FactoryGirl to Gemfile

```ruby
gem 'factory_girl_rails'
```

## Versioning the API

It might seem premature to think about versioning when we're just getting started but I like
to set it up at the beginning. It allows me to set up my routes so that additional versions
can be added easily in the future and I don't need to change the existing routes. The nice
thing is to specify a default versions so that clients at this stage don't even need to worry
about specifying a version number.

/config/routes.rb

```ruby
namespace :api, path: '/' do
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
    jsonapi_resources :auctions
  end
end
```

What that does is wrap up our routes in the API namespace but makes it accessible
from the root "/" url. We then set up a scope for each version, in this case we
only have v1, but in the future we can add additional scopes to support new versions.
We can also specify the default version. the ApiConstrants object handles
versioning through an Accept header. If any client wants a version other than the default
they just send an Accept header with their desired version.

/lib/api_constraints.rb

```ruby
class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.myapp.v#{@version}")
  end
end
```



## Add a Test for the /auctions Endpoint

spec/requests/auctions_spec.rb

```ruby
RSpec.describe "Auctions RESTful API" do
  describe "GET /auctions" do

    it "returns all the auctions" do
      FactoryGirl.create :auction, name: "General Auction"

      get "/auctions", {}, { "Accept" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      print body
      #auction_titles = body.map { |m| m["title"] }

      expect(body["data"][0]["name"]).to eq("General Auction")
    end
  end
end
```

Run the test to see it fail:

```console
rspec spec/requests/auctions_spec.rb
```

## Get test passing

