# frozen_string_literal: true

class DeveloperCliquesFileManager
  class << self
    def read(input_file)
      content = File.read(input_file)
      content.split("\n")
    end

    def write(max_cliques:, output_file:)
      file = File.open(output_file, 'w')
      file.puts max_cliques_to_s(max_cliques)
      file.close
    end

    private

    def order_max_cliques(max_cliques)
      max_cliques.map do |e|
        e.map(&:handle)
      end.map(&:sort).sort_by(&:size).reverse
    end

    def max_cliques_to_s(max_cliques)
      order_max_cliques(max_cliques).map do |e|
        e.join(' ')
      end.join("\n")
    end
  end
end
