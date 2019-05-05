# frozen_string_literal: true

require_relative '../max_cliques_finder'
require_relative '../developer'
require_relative '../developer_graph'
require 'pry'

describe Developer do
  let(:handle)               { 'paco' }
  let(:handle_list)          { %w[paco roberto javi rodrigo pedro] }
  let(:developer_graph)      { DeveloperGraph.new(handle_list) }
  let(:github_handle_list)   { %w[roberto javi rodrigo] }
  let(:twitter_handle_list)  { %w[roberto javi pedro] }

  it '#find_conexions' do
    allow_any_instance_of(DeveloperGraph).to receive(:find_conexions)
                                         .and_return(nil)
    allow(GithubClient).to receive(:find_conexions).with(handle: handle,
                                                         handle_list: handle_list)
                                                   .and_return(github_handle_list)
    allow(TwitterClient).to receive(:find_conexions).with(handle: handle,
                                                          handle_list: handle_list)
                                                    .and_return(twitter_handle_list)
    conexions = described_class.new(handle).find_conexions(developer_graph)
    expect(conexions.map(&:handle)).to match_array %w[javi roberto]
  end
end
