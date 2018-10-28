# frozen_string_literal: true

# Copyright 2014-2018 Maxine Michalski <maxine@furfind.net>
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

require 'open-uri'
require 'uri'
require 'json'

require_relative 'weasyl/api'

# Namespace for all classes in this gem.
# @author Maxine Michalski
# @since 0.1.0
module Weasyl
  MAJOR = 0
  MINOR = 1
  PATCH = 0
  NAME = 'weasyl'
  VERSION = "#{MAJOR}.#{MINOR}.#{PATCH}"
end
