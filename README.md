[![Build Status](https://travis-ci.org/whatisinternet/ToTrello.svg?branch=master)](https://travis-ci.org/whatisinternet/ToTrello)
# Totrello

TODO: Turns Todo items into Trello cards

## Notes

This is very early in development and makes several assumptions.
 + As it stands you cannot specify the board you want todo items posted to. They are always posted to a board with the projects name
 + Todo items are placed into the To Do list by default


## Installation

Install it yourself as:

    $ gem install totrello


## Usage

 + You must define TRELLO_DEVELOPER_PUBLIC_KEY & TRELLO_MEMBER_TOKEN
 + Generate your TRELLO_DEVELOPER_PUBLIC_KEY at: [https://trello.com/1/appKey/generate](https://trello.com/1/appKey/generate)
 + Generate your TRELLO_MEMBER_TOKEN at: https://trello.com/1/authorize?key=[TRELLO_DEVELOPER_PUBLIC_KEY]&name=ToTrelloGem&expiration=never&response_type=token&scope=read,write

    $ export TRELLO_DEVELOPER_PUBLIC_KEY='[Your key here]'
    $ export TRELLO_MEMBER_TOKEN='[Your key here]'


    ### To Index the current working folder and create trello cards for it
    $ ToTrello

    ### To index and create cards for another folder
    $ ToTrello [some other folder with full path]

## Contributing

1. Fork it ( https://github.com/whatisinternet/totrello/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
