module Matcher
  class Fuzzy
    
    def initialize()    
    end
    
    def match(text, files)
      files.select do |file_name| 
        match_file(text, file_name)
      end
    end
    
    def match_file(text, file_name)
      pattern_path = text.split("/")
      file_path = file_name.split("/")
      
      pattern = pattern_path.pop
      file = file_path.pop
      
      # puts "*"*5      
      # ["pattern", "pattern_path", "file", "file_path"].each {|name| puts "#{name}: #{eval(name)}"}
      # puts "*"*5
      if pattern_path && pattern_path.size > 0
        if file_path.size == 0
          puts "returning false for file_path == 0"
          return false 
        end
         if !file.match(pattern)
          puts "returning false for end file not matching for file: #{file} and pattern: #{pattern}"
          return false
        end
        
        pattern = pattern_path.shift
        file = file_path.shift
        
        
        while true
          if file.match(pattern)
            pattern = pattern_path.shift
            file = file_path.shift
          else
            file = file_path.shift
          end
          
          return true if pattern_path.empty?
          return false if file_path.empty? && !pattern_path.empty?          
        end
      else
        file.match(pattern)          
      end
    end
    
  end  
end
