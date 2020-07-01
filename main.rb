# frozen_string_literal: true

require_relative 'lib/videos_parser'
require_relative 'lib/topic_finder'

VIDEOS_PATH = './videos.json'

begin
  videos = VideosParser.parse(VIDEOS_PATH)
rescue StandardError => e
  puts e
  return
end

topic_finder = TopicFinder.new
topics_max_views_count = topic_finder.with_max_views_count(videos)

puts "Topic(s) with max views count are '#{topics_max_views_count.join(',')}'"
