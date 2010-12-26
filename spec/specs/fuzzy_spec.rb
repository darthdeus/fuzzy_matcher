require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fuzzy do
  
  let(:matcher) { Fuzzy.new }
  
  def files
    ["foo", "foo/bar", "foo/bar/baz"]
  end
  
  it "should match exact file name" do
    matcher.match("foo", "foo").should be_true
  end
  
  it "should match partial file name" do
    matcher.match_file("f", "foo").should be_true
  end
  
  it "should match nested file name" do
    matcher.match("bar", "foo/bar").should be_true
  end
  
  it "should match exact absolute path" do
    matcher.match_file("foo/bar", "foo/bar").should be_true
  end
  
  it "should match partial path" do
    matcher.match_file("foo/bar", "foo/baz/bar").should be_true
  end
  
  it "should match deep partial path" do
    matcher.match_file("foo/bar", "foo/baz/flux/buz/bar").should be_true
  end
  
  it "should match partial filenames with deep path" do
    matcher.match_file("f/b", "foo/baz/flux/buz/bar").should be_true
    matcher.match_file("f/ba", "foo/baz/flux/buz/bar").should be_true
    matcher.match_file("f/bar", "foo/baz/flux/buz/bar").should be_true
  end
  
  it "should match deep search with deep path" do
    matcher.match_file("b/e/g", "a/b/c/d/e/f/g").should be_true
  end

end


