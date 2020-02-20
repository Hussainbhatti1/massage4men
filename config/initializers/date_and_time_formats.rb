# November 8, 1983
Time::DATE_FORMATS[:long_without_time] = '%B %-d, %Y'
Date::DATE_FORMATS[:long_without_time] = '%B %-d, %Y'

# November 8
Time::DATE_FORMATS[:long_without_year] = '%B %-d'
Date::DATE_FORMATS[:long_without_year] = '%B %-d'

# November 8, 1983 2:22 a.m.
Time::DATE_FORMATS[:long_with_12_hour_time] = '%B %d, %Y %l:%M %p'

# 11/8/1983 2:22 a.m.
Time::DATE_FORMATS[:short_with_12_hour_time] = '%m/%d/%Y %l:%M %p'

# 11/8/1983
Time::DATE_FORMATS[:short_without_time] = '%-m/%-d/%Y'
Date::DATE_FORMATS[:short_without_time] = '%-m/%-d/%Y'

# 11/8
Time::DATE_FORMATS[:short_without_year] = '%-m/%-d'
Date::DATE_FORMATS[:short_without_year] = '%-m/%-d'

# 2:22 a.m.
Time::DATE_FORMATS[:time_only] = '%l:%M %p'
