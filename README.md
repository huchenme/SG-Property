# SG Property Test App
[![Build Status](https://travis-ci.org/huchenme/SG-Property.png?branch=master)](https://travis-ci.org/huchenme/SG-Property)
[![Code Climate](https://codeclimate.com/github/huchenme/SG-Property.png)](https://codeclimate.com/github/huchenme/SG-Property)
[![Dependency Status](https://gemnasium.com/huchenme/SG-Property.png)](https://gemnasium.com/huchenme/SG-Property)

Live site: [sgproperty.herokuapp.com](http://sgproperty.herokuapp.com "live site")

---

## Quick Start

This section is for developers to get this app up and running on a development machine.

Clone the git repository, install the gems and run the migrations:

```
git clone git@github.com:huch0003/SG-Property.git

bundle install

rake db:create

rake db:migrate

rails server # or unicorn -p 3000
```

## What have not been done yet

* Search field validation
* Phone number for STProperty
* Use [jQuery plugin](http://www.datatables.net/ "DataTables (table plug-in for jQuery)") to make table easier to search