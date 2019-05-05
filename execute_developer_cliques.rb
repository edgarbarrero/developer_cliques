# !/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'developer_cliques'

input_file = ARGV[0]
output_file = ARGV[1]
DeveloperCliques.perform(input_file: input_file, output_file: output_file)
