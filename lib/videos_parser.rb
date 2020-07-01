# frozen_string_literal: true

require 'json'

# Represent a videos parser.
class VideosParser
  def self.parse(filepath)
    raise "Unable to find #{filepath} file." unless File.exist?(filepath)

    json = File.read(filepath)

    begin
      videos = JSON.parse(json)
    rescue JSON::ParserError
      return []
    end

    videos
  end
end
