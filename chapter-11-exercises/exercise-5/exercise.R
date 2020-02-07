# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

View(flights)

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
dep_delay_by_month <- flights %>% 
  group_by(month) %>% 
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) 
print(dep_delay_by_month)

# Which month had the greatest average departure delay?
greatest_dep_delay <- dep_delay_by_month %>% 
  filter(avg_dep_delay == max(avg_dep_delay))
print(greatest_dep_delay)

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
plot(dep_delay_by_month)

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
highest_arrival_delays <- flights %>% 
  group_by(dest) %>% 
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  arrange(-avg_arr_delay) %>% 
  head()
print(highest_arrival_delays)

# You can look up these airports in the `airports` data frame!
View(airports)

airports %>% 
  filter(faa == "CAE")

# Which city was flown to with the highest average speed?
fastest_dest <- flights %>% 
  group_by(dest) %>% 
  mutate(speed = distance / (hour * 360 + minute * 60)) %>% 
  summarize(avg_speed = mean(speed, na.rm = TRUE)) %>% 
  filter(avg_speed == max(avg_speed)) %>% 
  pull(dest)
print(fastest_dest)
