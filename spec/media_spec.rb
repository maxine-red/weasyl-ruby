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

describe Weasyl::Media, '.new' do
  it 'returns a Media objext' do
    expect(Weasyl::Media.new(thumbnail: [{ mediaid: 1,
                                           url: 'https://example.org' }])).to(
                                             be_a Weasyl::Media
                                           )
  end
end

media = Weasyl::Media.new(thumbnail: [{ mediaid: 1,
                                        url: 'https://example.org' }],
                          cover: [{ mediaid: 1,
                                    url: 'https://example.org' }],
                          submission: [{ mediaid: 1,
                                         url: 'https://example.org' }])

describe Weasyl::Media, '#thumbnails' do
  it 'returns an array of thumbnail itmes' do
    expect(media.thumbnails).to be_an Array
    expect(media.thumbnails.first).to be_a Weasyl::Thumbnail
  end
end

describe Weasyl::Media, '#covers?' do
  it 'returns an indicator of if this media container has covers or not' do
    expect(media.covers?).to be true
  end
end

describe Weasyl::Media, '#media_files?' do
  it 'returns an indicator of if this media container has media_files or not' do
    expect(media.media_files?).to be true
  end
end

describe Weasyl::MediaItem, '.new' do
  it 'returns a MediaItem' do
    expect(Weasyl::MediaItem.new(mediaid: 1,
                                 url: 'https://example.org')).to(
                                   be_a Weasyl::MediaItem
                                 )
  end
end
media_item = Weasyl::MediaItem.new(mediaid: 1, url: 'https://example.org',
                                   links: {
                                     cover: [{ mediaid: 1,
                                               url: 'https://example.org' }]
                                   })

describe Weasyl::MediaItem, '#id?' do
  it 'returns an indication of if this item has an id' do
    expect(media_item.id?).to be true
  end
end

describe Weasyl::MediaItem, '#links?' do
  it 'returns an indication of if this item has links' do
    expect(media_item.links?).to be true
  end
end

describe Weasyl::Link, '.new' do
  it 'returns Link objects for various link types' do
    expect(Weasyl::Link.new(:cover,
                            [{ mediaid: 1, url: 'https://example.org' }])).to(
                              be_a Weasyl::Link
                            )
    expect(Weasyl::Link.new(:thumbnail,
                            [{ mediaid: 1, url: 'https://example.org' }])).to(
                              be_a Weasyl::Link
                            )
    expect(Weasyl::Link.new(:submission,
                            [{ mediaid: 1, url: 'https://example.org' }])).to(
                              be_a Weasyl::Link
                            )
    expect do
      Weasyl::Link.new(:test,
                       [{ mediaid: 1, url: 'https://example.org' }])
    end .to(
      raise_error ArgumentError
    )
  end
end
