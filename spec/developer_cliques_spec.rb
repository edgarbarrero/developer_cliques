# frozen_string_literal: true

require_relative '../github_client'
require_relative '../twitter_client'
require_relative '../developer_cliques'
require 'pry'

describe 'developer_cliques script' do
  it 'works ok' do
    test_io = StringIO.new
    allow(File).to receive(:open).and_return(test_io)

    mock_conexions

    DeveloperCliques.perform(input_file: 'spec/test_data/developer_cliques.txt',
                             output_file: 'fake.txt')
    expect(test_io.string).to eq "alejandro diego jaime paco\n"
  end

  def mock_conexions
    #        alejandro
    #      /     |     \
    #   paco  -     -  jaime
    #      \     |     /
    #         diego

    dev_list = %w[paco alejandro jaime diego]
    dev_list.each do |handle|
      handle_list = dev_list - [handle]
      allow(GithubClient).to receive(:find_conexions).with(handle: handle,
                                                           handle_list: handle_list)
                                                     .and_return(handle_list)
      allow(TwitterClient).to receive(:find_conexions).with(handle: handle,
                                                            handle_list: handle_list)
                                                      .and_return(handle_list)
    end
  end
end
