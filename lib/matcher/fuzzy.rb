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
        # doesn't match if search is deeper than the file, 
        # eg. search: a/b and file is only b
        # or doesn't match the filename
        if file_path.size == 0 || !Fuzzy.match_string(pattern, file)
          puts "ERR: #{pattern} didn't match #{file}"
          return false 
        end
        pattern = pattern_path.shift
        file = file_path.shift
        
        while true
          pattern = pattern_path.shift if file.match(pattern)
          file = file_path.shift
            
          return true if pattern_path.empty?
          if file_path.empty? && !pattern_path.empty?          
            puts "ERR: file got empty before pattern"
            return false 
          end
        end
      else
        file.match(pattern)          
      end      
    end
    
    #
    def self.match_string(text, string)
      pattern = text.split ""
      target = string.split ""
      last = 0
      
      while not pattern.empty?
        letter = pattern.shift
        i = target.index(letter)
        return false unless i
        
        last = i + 1
        target = target[last..-1]
      end
      true
    end
        
  end  
end
