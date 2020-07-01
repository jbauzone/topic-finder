# frozen_string_literal: true

# Represent a topic finder.
class TopicFinder
  TOPIC_IDS_FIELD = 'topic_ids'
  VIEWS_COUNT_FIELD = 'views_count'

  def with_max_views_count(videos)
    topics_with_views_count = videos.each_with_object(Hash.new(0)) do |video, topics|
      next unless video.key?(TOPIC_IDS_FIELD) && video.key?(VIEWS_COUNT_FIELD)

      video[TOPIC_IDS_FIELD].each do |topic_id|
        topics[topic_id] += video[VIEWS_COUNT_FIELD]
      end
    end

    max_views_count = topics_with_views_count.values.max_by { |v| v }
    topics_with_views_count
      .select { |_k, v| v == max_views_count }
      .keys
  end
end
