module Matcher
  class Fuzzy
    
    # Matches all files with the search string  
    #
    # == Parameters:
    # text::
    #  Search string, can contain full file name with path or just the file name.
    #  Name of each directory in the path doesn't have to be specified exactly.
    #
    # files::
    #  Array of files to match the search string
    #
    # == Returns::
    # array of all the files that match the path
    #
    def self.match(text, files)
      files.select do |file_name| 
        match_file(text, file_name)
      end
    end
    
    
    # Test if search string matches file name
    # 
    # == Parameters:
    # text::
    #  Search string, can contain full file name with path or just the file name.
    #  Name of each directory in the path doesn't have to be specified exactly.
    #
    # file_name::
    #  File name of the target file, can contain either just the file name,
    #  or the whole path.
    #
    # == Returns::
    # true on positive match, false on negative
    #
    def self.match_file(text, file_name)
      pattern_path = text.split("/")
      file_path = file_name.split("/")
      
      pattern = pattern_path.pop
      file = file_path.pop
      
      # if there is path specified in the search
      if pattern_path && pattern_path.size > 0
        # doesn't match if search is deeper than the file, eg. search: a/b and file is only b
        # or doesn't match the filename
        return false if file_path.size == 0 || !file.match(pattern)
          
        pattern = pattern_path.shift
        file = file_path.shift
        
        while true
          pattern = pattern_path.shift if file.match(pattern)
          file = file_path.shift
            
          return true if pattern_path.empty?
          return false if file_path.empty? && !pattern_path.empty?          
        end
      else
        file.match(pattern)          
      end
    end
    
  end  
end
