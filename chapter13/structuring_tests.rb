# let's take a look at the scaffolding surrounding tests

require 'test/unit'

# Unit tests fall naturally into higher level groupings called test
# cases and lower-level groupings which are the test methods themselves.
# A test case generally contains all the tests relating to a particular
# facility or feature.
#
# The classes that represent test cases must be subclasses of
# Test::Unit::TestCase
# The methods that hold the assertions must have names that start
# with test.
#
# Often you'll find all the test methods within a test case start
# by setting up a particular scenario. Each method then probes
# some aspect of that scenario. Finally each method might then tidy
# up after itself.

# e.g. we might be testing a class that extracts jukebox playlists
# from a database

require_relative 'playlist_builder'

class TestPlaylistBuilder < Test::Unit::TestCase

  def test_empty_playlist
    db = DBI.connect('DBI:mysql:playlists')
    pb = PlaylistBuilder.new(db)
    assert_empty(pb.playlist)
    db.disconnect
  end

  def test_artist_palylist
    db = DBI.connect('DBI:mysql:playlists')
    pb = PlaylistBuilder.new(db)
    pb.include_artist('krauss')
    refute_empty(pb.playlist, "Playlist shouldn't be empty")
    pb.playlist.each do |entry|
      assert_match(/krauss/i, entry.artist)
    end
    db.disconnect
  end

  def test_title_playlist
    db = DBI.connect('DBI:mysql:playlists')
    pb = PlaylistBuidler.new(db)
    pb.include_title("midnight")
    refute_empty(pb.playlist, "Playlist shouldn't be empty")
    pb.playlist.each do |entry|
      assert_match(/midnight/i, entry.title)
    end
    db.disconnect
  end
end


# test methods comprise 3 parts:
# 1) setup
# 2) test
# 3) teardown
#
# We can take advantage of this by using special setup and teardown
# methods provided in TestUnit to factor out common code

class TestPlaylistBuilder < Test:Unit:TestCase
  # run before every method
  def setup
    @db = DBI.connect('DBI:mysql:playlists')
    @pb = PlaylistBuilder.new(@db)
  end

  # run after every method
  def teardown
    @db.disconnect
  end

  def test_empty_playlist
    assert_empty(@pb.playlist)
  end

  def test_artist_palylist
    @pb.include_artist("krauss")
    refute_empty(@pb.playlist, "Playlist shouldn't be empty")
    @pb.playlist.each do |entry|
      assert_match(/krauss/i, entry.artist)
    end
  end

  def test_title_playlist
    @pb.include_title("midnight")
    refute_empty(@pb.playlist, "Playlist shouldn't be empty")
    @pb.playlist.each do |entry|
      assert_match(/midnight/i, entry.title)
    end
  end
end
