#!/usr/bin/env python

from pandocfilters import toJSONFilter, RawInline
import re

ov_pat = re.compile(r'^(\\\w+)(\{<[0-9-+]+>})({.*)$',flags=re.DOTALL)

def overlay_filter(key, value, fmt, meta):
    if key == 'RawInline' and value[0] == 'tex':
        m = ov_pat.match(value[1])
        if m:
            c = m.group(1)
            c += re.sub(r'^\{|}$', "", m.group(2))
            c += m.group(3)
            return RawInline("tex", c)

if __name__ == "__main__":
    toJSONFilter(overlay_filter)


