class Developer
  attr_accessor :handle, :connections

  def initialize(handle)
    @handle = handle
  end

  def connections_count
    return 0 if connections.nil?

    connections.count
  end

  def find_connections(dev_graph)
    dev_list = dev_graph.all - [self]

    github_connections = find_github_connections(dev_list)
    twitter_connections = find_twitter_connections(dev_list)
    common_connections = github_connections & twitter_connections
    self.connections = common_connections.map { |h| dev_graph.find(h) }
  end

  # TODO: reduce duplicity in this methods
  def find_github_connections(dev_list)
    dev_list_handles = dev_list.map(&:handle)
    GithubClient.find_connections(handle: handle, handle_list: dev_list_handles)
  end

  def find_twitter_connections(dev_list)
    dev_list_handles = dev_list.map(&:handle)
    TwitterClient.find_connections(handle: handle, handle_list: dev_list_handles)
  end
end
