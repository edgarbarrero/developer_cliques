
require_relative 'developer'

class DeveloperGraph
  attr_accessor :all

  def initialize(handles_list)
    @all = handles_list.each_with_object([]) do |handle, arr|
      arr << Developer.new(handle)
    end
    find_connections
  end

  def find(handle)
    all.detect { |d| d.handle == handle.to_s }
  end

  def find_connections
    all.each do |developer|
      developer.find_connections(self)
    end
  end
end
