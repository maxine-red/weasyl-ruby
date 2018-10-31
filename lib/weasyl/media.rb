# frozen_string_literal: true

# Copyright 2018 Maxine Michalski <maxine@furfind.net>
#
# This file is part of Weasyl.
#
# Weasyl is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Weasyl is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Weasyl.  If not, see <http://www.gnu.org/licenses/>.

module Weasyl
  # Container for media information
  # @author Maxine Michalski
  # @since 0.1.0
  class Media
    # @return [Array<Weasyl::Thumbnail>] List of thumbnails attached to this
    # media item
    attr_reader :thumbnails

    # @return [Array<Weasyl::Thumbnail>] List of cover images attached to this
    # media item
    attr_reader :covers

    # @return [Array<Weasyl::Thumbnail>] List of media files attached to this
    # media item
    attr_reader :media_files

    # Initializer for a Media object
    # @author Maxine Michalski
    # @since 0.1.0
    # @notice Special thumbnail objects are not supported at this point
    # @return object
    def initialize(media)
      @thumbnails = media[:thumbnail].map { |m| Weasyl::Thumbnail.new(m) }
      unless media[:cover].nil?
        @covers = media[:cover].map { |m| Weasyl::Cover.new(m) }
      end
      return if media[:submission].nil?
      @media_files = media[:submission].map { |m| Weasyl::MediaFile.new(m) }
    end

    # Test for the presence of covers
    # @author Maxine Michalski
    # @since 0.1.0
    # @return [Boolean]
    def covers?
      !@covers.nil?
    end

    # Test for the presence of media files
    # @author Maxine Michalski
    # @since 0.1.0
    # @return [Boolean]
    def media_files?
      !@media_files.nil?
    end
  end

  # Base class for media items
  # @author Maxine Michalski
  # @since 0.1.0
  class MediaItem
    # @return [Integer] Media ID of this item
    # @notice Can be nil
    attr_reader :id

    # @return [URI] Media URL to thumbnail
    attr_reader :url

    # @return [Array<Weasyl::Link>] Links to other media
    # @notice This attribute can be nil
    attr_reader :links

    # Shared initializer for all Media items
    # @author Maxine Michalski
    # @since 0.1.0
    def initialize(item)
      @id = item[:mediaid]
      @url = URI.parse(item[:url])
      return if item[:links].nil?
      @links = item[:links].map do |k, v|
        Weasyl::Link.new(k, v)
      end
    end

    # Indicator of if this MediaItem has an ID or not
    # @author Maxine Michalski
    # @since 0.1.0
    # @return [Boolean]
    def id?
      !@id.nil?
    end

    # Indicator of if this MediaItem object has links or not
    # @author Maxine Michalski
    # @since 0.1.0
    # @return [Boolean]
    def links?
      !@links.nil?
    end
  end

  # Container for Thumbnail information
  # @author Maxine Michalski
  # @since 0.1.0
  class Thumbnail < MediaItem
  end

  # Container for cover images
  # @author Maxine Michalski
  # @since 0.1.0
  class Cover < MediaItem
  end

  # Container for Submission media info (the actual file)
  # @author Maxine Michalski
  # @since 0.1.0
  class MediaFile < MediaItem
  end

  # A relationship between MediaItems
  # @author Maxine Michalski
  # @since 0.1.0
  class Link
    # @return [Symbol] Type of item this link links
    attr_reader :type

    # @return [Array<Weasyl::MediaItem>] Items that are linked to
    attr_reader :links

    # Initializer for link object
    # @author Maxine Michalski
    # @since 0.1.0
    # @return object
    def initialize(type, link)
      case @type = type
      when :cover
        @links = link.map { |l| Weasyl::Cover.new(l) }
      when :thumbnail
        @links = link.map { |l| Weasyl::Thumbnail.new(l) }
      when :submission
        @links = link.map { |l| Weasyl::MediaFile.new(l) }
      else
        raise ArgumentError, "Unknown type: #{@type}"
      end
    end
  end
end
