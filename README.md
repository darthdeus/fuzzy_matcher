# Fuzzy Matcher Library

Intended to match partial search to file path ... example from specs:

    matcher.match_file("b/e/g", "aa/bb/cc/dd/ee/ff/gg").should be_true
    matcher.match_file("b/e/g", "az/bz/cz/dz/ez/fz/gz").should be_true
    matcher.match_file("b/e/g", "zaz/zbz/zcz/zdz/zez/zfz/zgz").should be_true    
    
# Performance wasn't tested yet