# frozen_string_literal: true

# Represent a topic finder.
class TopicFinder
  def with_max_views_count(videos)
    topics_with_views_count = videos.each_with_object(Hash.new(0)) do |video, topics|
      next unless video.key?('topic_ids') && video.key?('views_count')

      video['topic_ids'].each do |topic_id|
        topics[topic_id] += video['views_count']
      end
    end

    max_views_count = topics_with_views_count.values.max_by { |v| v }
    topics_with_views_count
      .select { |_k, v| v == max_views_count }
      .keys
  end
end
