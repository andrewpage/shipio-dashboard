# Populate the graph with some random points
points = []
(1..10).each do |i|
  points << { x: i, y: rand(50) }
end
last_x = points.last[:x]

SCHEDULER.every '1s' do
  points.shift
  last_x += 1
  points << { x: last_x, y: 55 }

  send_event('builds', points: points)
end