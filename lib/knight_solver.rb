# frozen_string_literal: true

require 'set'

# This module stores the methods necessary for determining the shortest path a knight
# chesspiece can take to get from any one square to another on a chessboard.
module KnightSolver
  extend self

  Node = Data.define(:position, :parent)

  def knight_moves(start_pos, end_pos)
    path = shortest_path(start_pos, end_pos)
    if path.nil?
      puts 'Could not find path.'
    else
      puts "You made it in #{path.size - 1} moves! Here's your path:"
      path.each { |pos| p pos }
    end
  end

  private

  def shortest_path(start_pos, end_pos) # rubocop:disable Metrics/MethodLength
    queue = [Node.new(start_pos, nil)]
    visited = Set.new

    until queue.empty?
      curr_node = queue.shift

      return reconstruct_path(curr_node) if curr_node.position == end_pos

      next_moves = available_moves(*curr_node.position)

      next_moves.each do |next_pos|
        unless visited.include?(next_pos)
          visited.add(next_pos)
          queue.push(Node.new(next_pos, curr_node))
        end
      end
    end
  end

  def available_moves(row, col)
    offsets = [2, -2].product([1, -1]) + [1, -1].product([2, -2])
    offsets.filter_map do |row_offset, col_offset|
      new_row = row + row_offset
      new_col = col + col_offset

      new_pos = [new_row, new_col]
      new_pos if new_pos.all? { |coord| coord.between?(0, 7) }
    end
  end

  def reconstruct_path(node)
    path = []
    curr_node = node

    until curr_node.nil?
      path.unshift(curr_node.position)
      curr_node = curr_node.parent
    end

    path
  end
end
