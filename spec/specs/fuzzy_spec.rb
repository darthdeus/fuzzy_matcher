require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fuzzy do
  
  def files
    ["README.md", "spec/spec_helper.rb", 
      "spec/specs/fuzzy_spec.rb", "autotest/discover.rb", 
      "lib/matcher.rb", "lib/matcher/fuzzy.rb"]
  end
  
  context "filter" do
    it "should match only files without directories with the same name" do
      Fuzzy.match("spec", files).should == ["spec/spec_helper.rb",
                                            "spec/specs/fuzzy_spec.rb"]
    end
    
    it "should match single letter search only to filenames" do
      Fuzzy.match("m", files).should == ["README.md", "lib/matcher.rb"]
      Fuzzy.match("R", files).should == ["README.md"]
    end
    
    it "should match specific nested search only to one file" do
      Fuzzy.match("l/m", files).should == ["lib/matcher.rb"]
      Fuzzy.match("s/f", files).should == ["spec/specs/fuzzy_spec.rb"]
    end
    
    it "should match specific deeply nested search only to one file" do
      Fuzzy.match("s/s/f", files).should == ["spec/specs/fuzzy_spec.rb"]
    end
  end

  context "file match" do
    context "wihout directory" do
      it "should match exact file name" do
        "foo".should match_file("foo")
      end
    
      it "should match partial file name" do
        "f".should match_file("foo")
      end
    end
    
    context "with single nesting" do
      it "should match nested file name" do
        "bar".should match_file("foo/bar")
      end
      
      it "should match exact absolute path" do
        "foo/bar".should match_file("foo/bar")
      end
    end
    
    context "deep path" do
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
      
      it "should work" do
        "s/f".should_not match_file("lib/matcher/fuzzy.rb")
      end
    end
  end
  
  context "string match" do
    it "should match repetitive characters" do
      "g".should match_string("gg")
    end
    
    it "should work" do
      "s".should_not match_string("f")
    end
    
    it "should match exact string" do
      "foo".should match_string("foo")
    end
    
    it "should match partial string" do
      "f".should match_string("foo")
    end
    
    it "should match fuzzy partial string" do
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


