# Akane::Kinesis
storage plugin for [akane](https://github.com/sorah/akane/) that post to Amazon Kinesis.

## Installation

Add this line to your application's Gemfile:

    gem 'akane-kinesis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install akane-kinesis

## Usage

`akane.yml`

```yml
storages:
  - kinesis:
      aws_access_key_id: xxx
      aws_secret_access_key: xxxx
      region: ap-northeast-1
      kinesis_stream_name: twitter
```


## Contributing

1. Fork it ( https://github.com/yoshiori/akane-kinesis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
