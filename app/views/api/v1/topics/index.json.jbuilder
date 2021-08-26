json.topics @topics do |topic|
  json.partial 'topic', obj: topic
end
