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
  # Helper module to fetch information about messages.
  # @author Maxine Michalski
  # @since 0.1.0
  module Messages
    # Fetch a summary of new message counts
    # @author Maxine Michalski
    # @since 0.1.0
    # @return [Weasyl::Messages::Summary]
    def self.summary
      Weasyl::Messages::Summary.new(Weasyl::API.instance
        .fetch('messages/summary'))
    end

    # Fetch a list of submissions for the currently logged in user
    # @author Maxine Michalski
    # @since 0.1.0
    # @param count [Integer] max amount of submissions returned (100)
    # @param backtime [Integer] UNIX EPOCH, only submissions after this time are
    # returned
    # @param nexttime [Integer] UNIX EPOCH, only submissions before this time
    # are returned
    # @notice This method accepts a block, that goes through all available
    # submissions. While the non-block version only returns 100 submissions at
    # all.
    # @return [Weasyl::SubmissionList]
    def self.submissions(count = 100, backtime = 0, nexttime = Time.now.to_i)
      params = { count: count, backtime: backtime, nexttime: nexttime }
      subs = nil
      loop do
        subs = fetch_subs(params)
        break if subs[:nexttime].nil? || !block_given?
        subs[:submissions].each { |s| yield s }
        params[:nexttime] = subs[:nexttime]
      end
      subs
    end

    def self.fetch_subs(params)
      subs = Weasyl::API.instance.fetch('messages/submissions', params)
      subs[:submissions].map! do |s|
        Weasyl::Submission.new(s)
      end
      subs
    end
    private_class_method :fetch_subs

    # Class that represents a summary of message information.
    # @author Maxine Michalski
    # @since 0.1.0
    class Summary
      # @return [Integer] Count of unread comments
      attr_reader :comments

      # @return [Integer] Count of unread journals
      attr_reader :journals

      # @return [Integer] Count of unread notifications
      attr_reader :notifications

      # @return [Integer] Count of unseen submissions
      attr_reader :submissions

      # @return [Integer] Count of unread notes
      attr_reader :unread_notes

      # Initializer for Message summaries
      # @author Maxine Michalski
      # @since 0.1.0
      # @return object
      def initialize(sum)
        sum.each do |k, v|
          instance_variable_set("@#{k}".to_sym, v)
        end
      end
    end
  end
end
