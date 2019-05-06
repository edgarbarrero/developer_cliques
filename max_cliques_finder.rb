# frozen_string_literal: true

class MaxCliquesFinder
  def perform(developer_graph)
    bron_kerbosh(rrr: [], ppp: developer_graph.all, xxx: [])
  end

  private

  # Using Bron Kerbosch algorithm
  # https://en.wikipedia.org/wiki/Bron%E2%80%93Kerbosch_algorithm
  def bron_kerbosh(rrr:, ppp:, xxx:)
    report_as_max_clique(rrr) && return if ppp.size.zero? && xxx.size.zero?

    u = choose_pivot_vertex(ppp, xxx)
    vertices = vertices_to_iterate(vertex: u, collection: ppp)
    return (rrr + ppp + xxx) if vertices.nil?

    vertices.each do |v|
      bron_kerbosh(rrr: (rrr + [v]),
                   ppp: (ppp & v.connections),
                   xxx: (xxx & v.connections))
    end
    @max_cliques
  end

  def choose_pivot_vertex(ppp, xxx)
    possible_vertices = ppp + xxx
    possible_vertices.max_by(&:connections_count)
  end

  def report_as_max_clique(vertices)
    @max_cliques ||= []
    @max_cliques << vertices
  end

  def vertices_to_iterate(vertex:, collection:)
    return if vertex.nil?

    collection - vertex.connections
  end
end
