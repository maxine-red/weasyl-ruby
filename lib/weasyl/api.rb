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


require 'singleton'
module Weasyl
  # @author Maxine Michalski
  # Helper class to abstract actual API communication
  # @since 0.1.0
  class API
    include Singleton
    # Sets the API key. OAuth isn't supported yet.
    # @notice This method is not supposed to be used directly!
    # @return [String] API key for weasyl API
    attr_accessor :key
    def fetch(endpoint)
      raise ArgumentError, 'API key can\'t be empty' if @key.nil?
      JSON.parse(URI.parse("https://weasyl.com/api/#{endpoint}")
        .read('X-Weasyl-API-Key' => @key), symbolize_names: true)
    end
    
    # A test method to test API connection
    # @author Maxine Michalski
    # @return [Hash] A Hash object with user information
    # @since 0.1.0
    def whoami
      fetch(:whoami)
    end

    # Display version of weasyl API we connected to
    # @author Maxine Michalski
    # @since 0.1.0
    # @return [String] String that shows current weasyl API version
    def version
      fetch(:version)[:short_sha]
    end
  end
end
