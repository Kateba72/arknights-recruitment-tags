#! /usr/bin/env ruby

# Helper script to cross-check the number of operators known to the script

script = File.read('tags.rb')
operator_lines = script.lines.filter { it.match?(/^\s*Operator\.new/) }
comments = operator_lines.map { it.split('#', 2)[1] }
operators = comments.map { it.split(/\(|\)|,/) }.flatten.map(&:strip).filter { it != '' }

puts operators.size
