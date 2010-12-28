require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fuzzy do
  
  let(:matcher) { Fuzzy }
  
  def files
    ["foo", "foo/bar", "foo/bar/baz"]
  end
  
  context "file match" do
    
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
  
  context "string match" do
    it "should match exact string" do
      "foo".should match_string("foo")
    end
    
    it "should match partial string" do
      "f".should match_string("foo")
    end
    
    it "should match fuzzy partial string" do
      "f".should match_string("foo")
      "ur".should match_string("user")
      "usr".should match_string("user")
      "uc".should match_string("users_controller")
      "usc".should match_string("users_controller")
      "usrc".should match_string("users_controller")
      "userc".should match_string("users_controller")
      "user_c".should match_string("users_controller")
      "users_c".should match_string("users_controller")
      "users_ct".should match_string("users_controller")
      "users_ctrlr".should match_string("users_controller")
      "users_ctlr".should match_string("users_controller")
      "users_ctrr".should match_string("users_controller")
      "users_ctrrl".should_not match_string("users_controller")
    end
  end
end


