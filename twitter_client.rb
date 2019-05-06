# frozen_string_literal: true

require 'twitter'

class TwitterClient
  attr_accessor :client

  def initialize(handle)
    @handle = handle
    @client = init_client
  end

  def find_connections(handle:, handle_list:)
    followers = @client.followers(handle).map(&:screen_name)
    friends   = @client.friends(handle).map(&:screen_name)
    followers & friends & handle_list
  end

  private

  def init_client
    secrets = YAML.safe_load(File.read('spec/data_test_set.yml.erb'))

    Twitter::REST::Client.new do |config|
      config.consumer_key        = secrets[:consumer_key]
      config.consumer_secret     = secrets[:consumer_secret]
      config.access_token        = secrets[:access_token]
      config.access_token_secret = secrets[:access_token_secret]
    end
  end
end
