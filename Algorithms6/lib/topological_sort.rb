require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  arr = []
  in_order = []
  vertices.each do |vtx|
    arr << vtx if vtx.in_edges.length == 0
  end
  until arr.empty?
    edges = []
    curr_vtx = arr[-1]
    in_order << arr.pop
    curr_vtx.out_edges.each do |edge|
      if edge.to_vertex.in_edges.length == 1
        arr.unshift(edge.to_vertex)
      end
      edges << edge
    end
    edges.each do |edge|
      edge.destroy!
    end
  end
  if in_order.length == vertices.length
    return in_order
  else
    return []
  end
end
