# Totrello

TODO: Turns Todo items into Trello cards

## Notes

This is very early in development and makes several assumptions. It's also my first gem so keep that in mind.
 + As it stands you cannot specify the board you want todo items posted to. They are always posted to a board with the projects name
 + Todo items are placed into the To Do list by default


## Installation

Install it yourself as:

    $ gem install totrello


## Usage

You must define TRELLO_DEVELOPER_PUBLIC_KEY & TRELLO_MEMBER_TOKEN
  You can generate the TRELLO_DEVELOPER_PUBLIC_KEY at: [https://trello.com/1/appKey/generate](https://trello.com/1/appKey/generate)
  You can generate the TRELLO_MEMBER_TOKEN at: https://trello.com/1/authorize?key=[TRELLO_DEVELOPER_PUBLIC_KEY]&name=ToTrelloGem&expiration=never&response_type=token&scope=read,write

### Sample .rb file to use totrello
    require 'totrello'

    TRELLO_DEVELOPER_PUBLIC_KEY = [DEVELOPER_PK]
    TRELLO_MEMBER_TOKEN = [MEMBER_TOKEN]

    # WARNING: If nil is left in the new initializer totrello will assume you want to use the current working directory
    totrel = Totrello::Trelloize.new(nil)
    totrel.find_todo_items

## Contributing

1. Fork it ( https://github.com/whatisinternet/totrello/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
