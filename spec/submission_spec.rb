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

describe Weasyl::Submission, '.new' do
  it 'returns a Submission object' do
    expect(Weasyl::Submission.new(submitid: 1)).to be_a Weasyl::Submission
  end
end

sub = Weasyl::Submission.new(submitid: 1, owner: 'test', owner_login: 'test',
                             posted_at: Time.now.utc.strftime('%FT%TZ'),
                             rating: 'safe', subtype: 'test', tags: %w[a b],
                             title: 'test', type: 'test',
                             link: 'https://example.org',
                             media: {
                               thumbnail: [{ mediaid: 1,
                                             url: 'https://example.org' }]
                             })

describe Weasyl::Submission, '#owner' do
  it 'returns current submission\'s owner name' do
    expect(sub.owner).to eq('test')
  end
end

describe Weasyl::Submission, '#owner_login' do
  it 'returns current submission\'s owner login name' do
    expect(sub.owner_login).to eq('test')
  end
end

describe Weasyl::Submission, '#posted_at' do
  it 'returns current submission\'s post time' do
    expect(sub.posted_at).to be_a Time
  end
end

describe Weasyl::Submission, '#rating' do
  it 'returns current submission\'s rating' do
    expect(sub.rating).to eq('safe')
  end
end

describe Weasyl::Submission, '#id' do
  it 'returns current submission\'s id' do
    expect(sub.id).to eq(1)
  end
end

describe Weasyl::Submission, '#subtype' do
  it 'returns current submission\'s sub type' do
    expect(sub.subtype).to eq('test')
  end
end

describe Weasyl::Submission, '#tags' do
  it 'returns current submission\'s tags' do
    expect(sub.tags).to eq(%w[a b])
  end
end

describe Weasyl::Submission, '#title' do
  it 'returns current submission\'s title' do
    expect(sub.title).to eq('test')
  end
end

describe Weasyl::Submission, '#type' do
  it 'returns current submission\'s type' do
    expect(sub.type).to eq('test')
  end
end

describe Weasyl::Submission, '#link' do
  it 'returns current submission\'s link' do
    expect(sub.link).to be_an URI
  end
end

describe Weasyl::Submission, '#media' do
  it 'returns current submission\'s id' do
    expect(sub.media).to be_a Weasyl::Media
  end
end
