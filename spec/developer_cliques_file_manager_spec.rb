# frozen_string_literal: true

require_relative '../developer_cliques_file_manager'
require_relative '../developer'
require 'pry'

describe DeveloperCliquesFileManager do
  DEV_HANDLES = %w[paco alejandro jaime diego].freeze

  DEV_HANDLES.each do |dev_handle|
    let(dev_handle.to_sym) { Developer.new(dev_handle) }
  end

  it '#read returns correct cliques list' do
    developer_handles = described_class.read('spec/test_data/developer_cliques.txt')
    expect(developer_handles).to match_array DEV_HANDLES
  end

  it '#write create a correct file' do
    test_io = StringIO.new
    allow(File).to receive(:open).and_return(test_io)

    max_cliques = [[paco], [paco, alejandro, diego], [jaime, alejandro]]
    described_class.write(max_cliques: max_cliques, output_file: 'fake.txt')
    expect(test_io.string).to eq "alejandro diego paco\nalejandro jaime\npaco\n"
  end
end
