# frozen_string_literal: true

require_relative '../developer'
require 'pry'

describe DeveloperGraph do
  let(:handle)               { 'paco' }
  let(:handle_list)          { %w[paco roberto javi rodrigo pedro] }


  it '#find' do
    allow_any_instance_of(DeveloperGraph).to receive(:find_connections).and_return(nil)

    developer = described_class.new(handle_list).find(handle)
    expect(developer).to be_a Developer
    expect(developer.handle).to eq handle
  end
end
