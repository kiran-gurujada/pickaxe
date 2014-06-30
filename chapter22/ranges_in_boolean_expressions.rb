# A range used in a boolean expression acts as a flipflop
# turns ON on first match, turns OFF on second match
# the two-dot form differs from the three-dot form

a = (11..20).map {|i| (i % 4 == 0)..(i % 3 == 0) ? i : nil }
p a # => [nil, 12, nil, nil, nil, 16, 17, 18, nil, 20]

b = (11..20).map {|i| (i % 4 == 0)...(i % 3 == 0) ? i : nil }
p b # => [nil, 12, 13, 14, 15, 16, 17, 18, nil, 20]
