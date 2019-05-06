# frozen_string_literal: true

require_relative '../max_cliques_finder'
require_relative '../developer'
require_relative '../developer_graph'
require 'pry'

describe MaxCliquesFinder do
  it '#max_clique_list returns correct max cliques developer list' do
    # connections will set manually instead of use #find_connections
    allow_any_instance_of(Developer).to receive(:find_connections).and_return([])

    load_data_test.each do |_, data_set|
      max_cliques = described_class.new.perform(data_set[:developer_graph])
      expect(max_cliques).to match_array data_set[:max_cliques]
    end
  end

  def load_data_test
    # TODO: refactor candidate
    data_set = YAML.safe_load(File.read('spec/test_data/max_cliques_finder_test_data.yml'))

    data_set.each_with_object({}) do |(dev_list_name, data), h|
      developers = data['developers']
      developer_graph = DeveloperGraph.new(developers.keys)

      developers.keys.each do |dev_name|
        developer = developer_graph.find(dev_name)
        developer.connections = developers[dev_name].map { |d| developer_graph.find(d) }
      end

      max_cliques = data['max_cliques'].map do |e|
        e.map { |d| developer_graph.find(d) }
      end
      h[dev_list_name] = { 'developer_graph': developer_graph,
                           'max_cliques': max_cliques }
    end
  end
end
