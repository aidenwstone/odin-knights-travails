# frozen_string_literal: true

require_relative 'lib/knight_solver'

puts 'Please enter the starting coordinates, separated by a comma:'
start_pos = gets.split(',').map(&:to_i)
puts 'Please enter the ending coordinates, separated by a comma:'
end_pos = gets.split(',').map(&:to_i)

KnightSolver.knight_moves(start_pos, end_pos)
