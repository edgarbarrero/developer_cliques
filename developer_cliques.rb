# frozen_string_literal: true

require_relative 'developer_cliques_file_manager'
require_relative 'developer_graph'
require_relative 'max_cliques_finder'

# This class is used just to encapsulate the logic so it can be tested easily
class DeveloperCliques
  def self.perform(input_file:, output_file:)
    cliques_list = DeveloperCliquesFileManager.read(input_file)
    developer_graph = DeveloperGraph.new(cliques_list)
    max_cliques = MaxCliquesFinder.new.perform(developer_graph)
    DeveloperCliquesFileManager.write(max_cliques: max_cliques,
                                      output_file: output_file)
  end
end
