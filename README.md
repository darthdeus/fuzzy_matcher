# Fuzzy Matcher Library

Intended to match partial search to file path ... example from specs:

    "b/e/g".should match_file("aa/bb/cc/dd/ee/ff/gg")
    "b/e/g".should match_file("az/bz/cz/dz/ez/fz/gz")
    "b/e/g".should match_file("zaz/zbz/zcz/zdz/zez/zfz/zgz")
    
# Performance wasn't tested yet