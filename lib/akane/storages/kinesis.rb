require 'akane/storages/abstract_storage'
require 'aws-sdk'
require 'json'

module Akane
  module Storages
    class Kinesis < AbstractStorage

      DEFAULT_REGION = "us-east-1"

      def initialize(config: raise(ArgumentError, 'missing config'), logger: Logger.new($stdout))
        super

        @access_key_id = @config['aws_access_key_id'] || ENV['AWS_ACCESS_KEY_ID']
        @secret_access_key = @config['aws_secret_access_key'] || ENV['AWS_SECRET_ACCESS_KEY']
        @region = @config['region'] || DEFAULT_REGION
        @stream_name = @config['kinesis_stream_name']

        unless @access_key_id
          raise ArgumentError, "config `aws_access_key_id` is required"
        end
        unless @secret_access_key
          raise ArgumentError, "config `aws_secret_access_key` is required"
        end
        unless @stream_name
          raise ArgumentError, "config `kinesis_stream_name` is required"
        end
      end


      def record_tweet(account, tweet)

        kinesis.put_record(
          stream_name: @stream_name,
          data: tweet.attrs.merge(account: account).to_json,
          partition_key: "tweet"
        )
      end

      def mark_as_deleted(account, user_id, tweet_id)
        data = {
          account: account,
          user_id: user_id,
          tweet_id: tweet_id,
        }
        kinesis.put_record(
          stream_name: @stream_name,
          data: data.to_json,
          partition_key: "deletion"
        )
      end

      def record_event(account, event)
        kinesis.put_record(
          stream_name: @stream_name,
          data: event.attrs.merge(account: account).to_json,
          partition_key: "event"
        )
      end

      def record_message(account, message)
        kinesis.put_record(
          stream_name: @stream_name,
          data: message.attrs.merge(account: account).to_json,
          partition_key: "dm"
        )
      end

      def kinesis
        @kinesis ||= AWS::Kinesis.new(
          access_key_id: @access_key_id,
          secret_access_key: @secret_access_key,
          region: @region,
        ).client
      end
    end
  end
end
