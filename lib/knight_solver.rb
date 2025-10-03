# frozen_string_literal: true

require 'set'

# This module stores the methods necessary for determining the shortest path a knight
# chesspiece can take to get from any one square to another on a chessboard.
module KnightSolver
  extend self

  def knight_moves(start_pos, end_pos); end

  private

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
