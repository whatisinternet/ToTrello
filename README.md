[![Build Status](https://travis-ci.org/whatisinternet/ToTrello.svg?branch=master)](https://travis-ci.org/whatisinternet/ToTrello)
[![Gem Version](https://badge.fury.io/rb/totrello.svg)](http://badge.fury.io/rb/totrello)
[![Code Climate](https://codeclimate.com/github/whatisinternet/ToTrello/badges/gpa.svg)](https://codeclimate.com/github/whatisinternet/ToTrello)
[![Test Coverage](https://codeclimate.com/github/whatisinternet/ToTrello/badges/coverage.svg)](https://codeclimate.com/github/whatisinternet/ToTrello)
# Totrello

Turns Todo items into Trello cards

## Notes

If you do not specify a .totrello.yml file somewhere in your project ToTrello will assume:
 + The board will be called by the directory name ToTrello was run in
 + Todo items are placed into the To Do list by default


## Installation

Install it yourself as:

    $ gem install totrello


## Usage

### You must define TRELLO_DEVELOPER_PUBLIC_KEY & TRELLO_MEMBER_TOKEN
Generate your TRELLO_DEVELOPER_PUBLIC_KEY at: [https://trello.com/1/appKey/generate](https://trello.com/1/appKey/generate)
Generate your TRELLO_MEMBER_TOKEN at: https://trello.com/1/authorize?key=[TRELLO_DEVELOPER_PUBLIC_KEY]&name=ToTrelloGem&expiration=never&response_type=token&scope=read,write


    $ export TRELLO_DEVELOPER_PUBLIC_KEY='[Your key here]'
    $ export TRELLO_MEMBER_TOKEN='[Your key here]'

### Creating a .totrello.yml file (Must be in root directory):

The ToTrello yml file allows you to customize the way ToTrello functions:
+ Project_name : The name of the project (i.e. ToTrello)
+ board_name   : The Trello board you want to post to
+ default_list : The list you want your new todo items to post to
+ todo_types   : The types of todo items you want to capture
+ comment_style: How comments appear in your file types
+ file_types   : Types of files you want to include in the search
+ excludes     : The files or directories you want to exclude

#### Sample file:

    totrello:
              project_name: 'ToTrello'
              board_name: 'ToTrello'
              default_list: 'To Do'
              todo_types: ['TODO', '#TODO', '#TODO:', 'TODO:', 'FIXME', '#FIXME', '#FIXME:', 'FIXME:']
              comment_style: ['#','//']
              file_types: ['.rb','.yml']
              excludes: [
                        'pkg/',
                        'bin/',
                       ]

### To Index the current working folder and create trello cards for it

    $ ToTrello

### To index and create cards for another folder

    $ ToTrello [some other folder with full path]

## Contributing

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it ( https://github.com/whatisinternet/totrello/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
