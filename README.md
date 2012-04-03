# EmailDetector

A lightweight gem for detecting email addresses in text.

## Installation

Add this line to your application's Gemfile:

    gem 'email_detector'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install email_detector

## Usage

    emails = EmailDetector.new('You should invite joe@example.com and bob@example.com to the party!')
    emails.to_s # => "joe@example.com, bob@example.com"
    emails.map # => ["joe@example.com", "bob@example.com"]
    emails.ignored # => ["You should invite", "and", "to the party!"]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
