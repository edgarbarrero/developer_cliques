# frozen_string_literal: true

require 'twitter'
require 'yaml'

class TwitterClient
  # class var used in order to not load twitter client in each call to this class
  @@client = nil

  class << self

    def find_connections(handle:, handle_list:)
      init_client
      followers = @@client.followers(handle).map(&:screen_name)
      friends   = @@client.friends(handle).map(&:screen_name)
      followers & friends & handle_list
    end

    private

    def init_client
      return unless @@client.nil?

      secrets = YAML.safe_load(File.read('secrets.yml'))

      @@client = Twitter::REST::Client.new do |config|
        config.consumer_key        = secrets[:consumer_key]
        config.consumer_secret     = secrets[:consumer_secret]
        config.access_token        = secrets[:access_token]
        config.access_token_secret = secrets[:access_token_secret]
      end
    end
  end
end
