class Developer
  attr_accessor :handle, :conexions

  def initialize(handle)
    @handle = handle
  end

  def conexions_count
    return 0 if conexions.nil?

    conexions.count
  end

  def find_conexions(dev_graph)
    dev_list = dev_graph.all - [self]

    github_conexions = find_github_conexions(dev_list)
    twitter_conexions = find_twitter_conexions(dev_list)
    common_conexions = github_conexions & twitter_conexions
    self.conexions = common_conexions.map { |h| dev_graph.find(h) }
  end

  # TODO: reduce duplicity in this methods
  def find_github_conexions(dev_list)
    dev_list_handles = dev_list.map(&:handle)
    GithubClient.find_conexions(handle: handle, handle_list: dev_list_handles)
  end

  def find_twitter_conexions(dev_list)
    dev_list_handles = dev_list.map(&:handle)
    TwitterClient.find_conexions(handle: handle, handle_list: dev_list_handles)
  end
end
