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

require 'time'
require_relative 'media'

module Weasyl
  # Container for submission information
  # @author Maxine Michalski
  # @since 0.1.0
  class Submission
    # @return [String] Owner of submission
    attr_reader :owner

    # @return [String] Owner of submission
    attr_reader :owner_login

    # @return [Time] Timestamp when submission was uploaded
    attr_reader :posted_at

    # @return [String] Rating marker
    attr_reader :rating

    # @return [Integer] Submission id
    attr_reader :id

    # @return [String] Submission sub-type
    attr_reader :subtype

    # @return [Array<String>] Tags associated with this submission
    attr_reader :tags

    # @return [String] Title of submission
    attr_reader :title

    # @return [String] Type of submission
    attr_reader :type

    # @return [URI] Link to submision
    attr_reader :link

    # @return [Weasyl::Media] Media object for current submission
    attr_reader :media

    # Initializer for Submission containers
    # @author Maxine Michalski
    # @since 0.1.0
    # @return object
    def initialize(sub)
      sub.select! do |k, _|
        %i[rating tags link owner owner_login submitid title media posted_at
           subtype type].include?(k)
      end
      sub_prepared(sub).each do |k, v|
        instance_variable_set("@#{k}".to_sym, v)
      end
    end

    private

    def sub_prepared(sub)
      sub.map do |k, v|
        v = Time.parse(v) if k == :posted_at
        v = URI.parse(v) if k == :link
        v = Weasyl::Media.new(v) if k == :media
        k = :id if k == :submitid
        [k, v]
      end
    end
  end
end
