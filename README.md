# SG Property Test App

Live site: [sgproperty.herokuapp.com](http://sgproperty.herokuapp.com "live site")

# Quick Start

This section is for developers to get this app up and running on a development machine.

Clone the git repository, install the gems and run the migrations:

```
git clone git@github.com:huch0003/SG-Property.git

bundle install

rake db:create

rake db:migrate

rails server # or unicorn -p 3000
```

# What have not done yet

* search field validation
* phone number for STProperty