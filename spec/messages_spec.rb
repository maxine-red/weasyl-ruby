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

describe Weasyl::Messages do
  before :each do
    @uri = double(URI)
    allow(URI).to receive(:parse).and_return(@uri)
  end
  describe '.summary' do
    it 'returns a Summary obbject' do
      allow(@uri).to receive(:read).and_return('{"comments": 0}')
      expect(Weasyl::Messages.summary).to be_a Weasyl::Messages::Summary
    end
  end
end

describe Weasyl::Messages::Summary, '#comments' do
  it 'returns comment count' do
    expect(Weasyl::Messages::Summary.new(comments: 0).comments).to be 0
  end
end

describe Weasyl::Messages::Summary, '#journals' do
  it 'returns comment count' do
    expect(Weasyl::Messages::Summary.new(journals: 0).journals).to be 0
  end
end

describe Weasyl::Messages::Summary, '#submissions' do
  it 'returns comment count' do
    expect(Weasyl::Messages::Summary.new(submissions: 0).submissions).to be 0
  end
end

describe Weasyl::Messages::Summary, '#unread_notes' do
  it 'returns comment count' do
    expect(Weasyl::Messages::Summary.new(unread_notes: 0).unread_notes).to be 0
  end
end

describe Weasyl::Messages::Summary, '#notifications' do
  it 'returns comment count' do
    expect(Weasyl::Messages::Summary.new(notifications: 0).notifications).to(
      be 0
    )
  end
end
