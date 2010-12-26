require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fuzzy do
  
  let(:matcher) { Fuzzy }
  
  def files
    ["foo", "foo/bar", "foo/bar/baz"]
  end
  
  it "should match exact file name" do
    "foo".should match_file("foo")
  end
  
  it "should match partial file name" do
    "f".should match_file("foo")
  end
  
  it "should match nested file name" do
    "bar".should match_file("foo/bar")
  end
  
  it "should match exact absolute path" do
    "foo/bar".should match_file("foo/bar")
  end
  
  it "should match partial path" do
    "foo/bar".should match_file("foo/baz/bar")
  end
  
  it "should match deep partial path" do
    "foo/bar".should match_file("foo/baz/flux/buz/bar")
  end
  
  it "should match partial filenames with deep path" do
    "f/b".should match_file("foo/baz/flux/buz/bar")
    "f/ba".should match_file("foo/baz/flux/buz/bar")
    "f/bar".should match_file("foo/baz/flux/buz/bar")
    "fo/bar".should match_file("foo/baz/flux/buz/bar")
    "foo/bar".should match_file("foo/baz/flux/buz/bar")
    "foo/ba".should match_file("foo/baz/flux/buz/bar")
    "foo/b".should match_file("foo/baz/flux/buz/bar")
  end
  
  it "should match deep search with deep path" do
    "b/e/g".should match_file("a/b/c/d/e/f/g")
  end
  
  it "should match deep search with deep path with partial file names" do
    "b/e/g".should match_file("aa/bb/cc/dd/ee/ff/gg")
    "b/e/g".should match_file("az/bz/cz/dz/ez/fz/gz")
    "b/e/g".should match_file("zaz/zbz/zcz/zdz/zez/zfz/zgz")
  end

end


