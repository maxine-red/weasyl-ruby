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

Weasyl::API.instance.key = ''

describe Weasyl::API, '#whoami' do
  it 'fetches info about the currently logged in user' do
    uri = double(URI)
    allow(URI).to receive(:parse).and_return(uri)
    allow(uri).to receive(:read).and_return('{}')
    expect(Weasyl::API.instance.whoami).to be_a Hash 
  end
end

describe Weasyl::API, '#version' do
  it 'returns the currently connected weasyl API version' do
    uri = double(URI)
    allow(URI).to receive(:parse).and_return(uri)
    allow(uri).to receive(:read).and_return('{"short_sha": "deadbeef"}')
    expect(Weasyl::API.instance.version).to be_a String
  end
end
