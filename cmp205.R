# load packages
library(tidyverse)

# THE PROJECT:
# =========================================================
# We'll be writing some code to simulate an ORDER TRACKING SYSTEM
# for Molly Tea
# =========================================================

# Here is Molly Tea's current order queue (prices in CAD)
order_queue <- c(6.50, 7.00, 5.50, 8.00, 6.50, 7.50)
print("Welcome to Molly Tea! Here is our current order queue (CAD):")
print(order_queue)

# Checkpoint 1: A New Customer Arrives
# A customer just walked in and ordered a drink for $8.50.

print("================================================")
print("Checkpoint 1:")
print("================================================")

# Add the new $8.50 order to the queue
order_queue <- c(order_queue, 8.50)
print("New drink queue")
print(order_queue) # should print 6.5 7 5.5 8 6.5 7.5 8.5

# Checkpoint 2: Rewards Points Calculation
# We're building a new points system:
# For every $1 CAD spent, customers earn 1.5 rewards points.
#
# Our manager wants to know how many points each current order in the
# queue will earn for its customer. Write code to calculate the points for this order

print("================================================")
print("Checkpoint 2:")
print("================================================")

points_per_dollar <- 1.5

print("Here is our current order queue:")
print(order_queue) # 6.5 7 5.5 8 6.5 7.5 8.5

# Multiply every order price by the points rate (vector operation!)
points_per_order <- points_per_dollar * order_queue

print("Here are the rewards points each order will earn:")
print(points_per_order) # 9.75 10.5 8.25 12 9.75 11.25 12.75

# Now calculate the TOTAL points that will be given out
total_points <- sum(points_per_order)
print("Total rewards points being earned across all current orders:")
print(total_points) # 74.25

# Checkpoint 3: Daily Revenue Report (CAD to RMB)
# The owner wants to file a cross-border revenue report in RMB.
# Using vector operations, convert every order price to RMB, then
# report the total revenue from today's remaining queue in RMB.

# The exchange rate is 5.0 RMB per 1 CAD
exchange_rate <- 5.0

print("================================================")
print("Checkpoint 3:")
print("================================================")

# Convert all order prices to RMB using a vector operation
order_queue_RMB <- exchange_rate * order_queue

print("Here is our order queue converted to RMB:")
print(order_queue_RMB) # 32.5 35 27.5 40 32.5 37.5 42.5

# Sum up the total revenue
total_revenue_RMB <- sum(order_queue_RMB)
print("Total remaining queue revenue in RMB:")
print(total_revenue_RMB) # 247.5

# Checkpoint 4: Building the Orders Tibble
# Molly Tea is growing fast! Instead of a simple vector, we now want
# a full ORDER LOG — a tibble where each ROW is one order and
# each COLUMN is a different piece of information about that order.
#
# A tibble is tidyverse's version of a data frame (table).
# We use tibble() instead of data.frame() — it has fewer quirks.
#
# Columns:
#   orderNumber  — unique ID for the order
#   customerName — who placed the order
#   drinkName    — what they ordered
#   price        — cost in CAD
#   iceLevel     — 0.0 (no ice) to 1.0 (full ice)
#   sugarLevel   — 0.0 (no sugar) to 1.0 (full sugar)
#   notes        — any special instructions (empty string "" if none)
# Molly Tea is growing fast! Instead of a simple vector, we now want
# a full ORDER LOG — a tibble where each ROW is one order and
# each COLUMN is a different piece of information about that order.
#
# A tibble is tidyverse's version of a data frame (table).
# We use tibble() instead of data.frame() — it has fewer quirks.
#
# Columns:
#   orderNumber  — unique ID for the order
#   customerName — who placed the order
#   drinkName    — what they ordered
#   price        — cost in CAD
#   iceLevel     — 0.0 (no ice) to 1.0 (full ice)
#   sugarLevel   — 0.0 (no sugar) to 1.0 (full sugar)
#   notes        — any special instructions (empty string "" if none)

orders_df <- tibble(
  orderNumber  = c(1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009),
  customerName = c("Alice", "Bob",   "Alice", "Carol", "Bob",   "Carol", "Alice", "Carol", "Dave"),
  drinkName    = c("Taro Milk Tea",        "Brown Sugar Boba",     "Matcha Latte",
                   "Mango Slush",          "Classic Milk Tea",     "Strawberry Fruit Tea",
                   "Lychee Slush",         "Wintermelon Tea",      "Peach Tea"),
  price        = c(7.00, 6.50, 8.50, 8.00, 5.50, 7.00, 7.50, 6.50, 6.50),
  iceLevel     = c(1.00, 0.50, 0.75, 0.25, 1.00, 0.50, 0.00, 0.75, 1.00),
  sugarLevel   = c(1.00, 0.75, 0.50, 1.00, 0.25, 0.75, 0.50, 1.00, 0.75),
  notes        = c("", "Less ice please", "Oat milk substitute", "",
                   "No pearls", "", "Extra pearls", "", "")
)

print("================================================")
print("Checkpoint 4: Molly Tea Full Order Log")
print("================================================")
print(orders_df)

# --- Accessing a column with $ ---
# $ extracts the column as a VECTOR (not a tibble)
print("All drink names ordered today (vector via $):")
print(orders_df$drinkName)

print("All order prices in CAD (vector via $):")
print(orders_df$price)

# --- Accessing a single cell with [[row, col]] ---
# [[]] returns an atomic (single) value — not wrapped in a tibble
# Suppose we want the price of the 3rd order (Matcha Latte):
print("Price of order #3 using [[row, col]]:")
print(orders_df[[3, 4]])  # row 3, column 4 (price column)
# [1] 8.5

# --- Column arithmetic ---
# Once you access a column with $, you can do math on the whole vector at once.
# Which orders are "premium" drinks (price over $7.50)?
print("Is each order a premium-priced drink (price > $7.50)?")
print(orders_df$price > 7.50)
# [1] FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE

# What is the most expensive drink on today's orders?
print("Most expensive order today:")
print(max(orders_df$price))
# [1] 8.5

# Checkpoint 5: Customer Rewards Level Classification
# Molly Tea wants to classify customers into reward tiers based on
# their TOTAL spending across ALL of their orders:
#   - Level 2 (Gold):   total spend >= $20 CAD
#   - Level 1 (Silver): total spend  < $20 CAD
#
# We use the dplyr pipeline from tidyverse:
#   Read %>% as "and then" — it chains operations left to right.
#
#   group_by()  — splits the tibble into invisible groups by customerName
#   summarize() — collapses each group into one summary row
#   mutate()    — adds a new column without removing existing ones

print("================================================")
print("Checkpoint 5: Customer Rewards Level Classification")
print("================================================")

# Step 1: Group by customer and sum their total spending.

customer_totals <- orders_df %>%
  group_by(customerName) %>%
  summarize(totalSpend = sum(price))

print("Total spending per customer:")
print(customer_totals)
# Alice = 23.00  (7.00 + 8.50 + 7.50)
# Bob   = 12.00  (6.50 + 5.50)
# Carol = 21.50  (8.00 + 7.00 + 6.50)
# Dave  =  6.50

# Step 2: Use mutate() + ifelse() to add a rewardLevel column.
#         mutate() adds a new column without removing existing ones.
#         ifelse(condition, value_if_TRUE, value_if_FALSE)

customer_totals <- customer_totals %>%
  mutate(rewardLevel = ifelse(totalSpend >= 20, "Level 2 (Gold)", "Level 1 (Silver)"))

print("Final customer rewards tibble:")
print(customer_totals)
# # A tibble: 4 × 3
#   customerName  totalSpend rewardLevel
#   <chr>              <dbl> <chr>
# 1 Alice               23.0 Level 2 (Gold)
# 2 Bob                 12.0 Level 1 (Silver)
# 3 Carol               21.5 Level 2 (Gold)
# 4 Dave                 6.5 Level 1 (Silver)

# Checkpoint 6: Finding Orders with Special Notes
# The baristas need a list of all order numbers that have special
# instructions so they don't miss any customizations.
#
# We use which() to find the INDEXES of matching rows, then use
# those indexes to subset a column — the same pattern from lecture:
#
#   df$column[ which(df$other_column condition) ]

print("================================================")
print("Checkpoint 6: Orders with Special Notes")
print("================================================")

# Step 1: Find the ROW INDEXES where notes is not empty
note_indexes <- which(orders_df$notes != "")
print("Row indexes that have special notes:")
print(note_indexes) # [1] 2 3 5 7

# Step 2: Use those indexes to pull the corresponding order numbers
special_order_numbers <- orders_df$orderNumber[note_indexes]
print("Order numbers that need special attention:")
print(special_order_numbers) # [1] 1002 1003 1005 1007

# Step 3: Pull the actual note text the same way
special_notes <- orders_df$notes[note_indexes]
print("Their special instructions:")
print(special_notes) # "Less ice please" "Oat milk substitute" "No pearls" "Extra pearls"

# Checkpoint 7: Modifying Values and Adding New Columns
# Molly Tea just updated its menu — the Matcha Latte price has
# increased from $8.50 to $9.00. Let's update the tibble.
#
# To modify a specific value, combine which() with $ assignment:
#   df$column[ which(df$other_column == value) ] <- new_value

print("================================================")
print("Checkpoint 7: Modifying Values and Adding New Columns")
print("================================================")

orders_df$price[which(orders_df$drinkName == "Matcha Latte")] <- 9.00

print("Updated price list (Matcha Latte is now $9.00):")
print(orders_df$price) # [1] 7.00 6.50 9.00 8.00 5.50 7.00 7.50 6.50 6.50

# --- Adding a calculated column ---
# Vancouver charges 5% GST on beverages. Let's add a priceWithTax column.
# Assigning a calculation to a new column name creates it automatically.
orders_df$priceWithTax <- orders_df$price * 1.05

print("New priceWithTax column (price + 5% GST):")
print(orders_df$priceWithTax)
# [1] 7.350 6.825 9.450 8.400 5.775 7.350 7.875 6.825 6.825

# --- Adding a logical (TRUE/FALSE) column ---
# Flag any drink priced $8.00 or above as a "premium" item.
orders_df$isPremium <- orders_df$price >= 8.00

print("Which orders are premium drinks (price >= $8.00)?")
print(orders_df$isPremium)
# [1] FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE

# Checkpoint 8: Handling Missing Values (NA)
# Not all data is complete. R represents missing values as NA
# (Not Available). Let's create a small tibble where some sugar
# levels were not recorded by the barista.
#
# Rule of thumb: any operation involving NA returns NA.
# Use na.rm = TRUE to tell functions to skip NA values.

print("================================================")
print("Checkpoint 8: Missing Values (NA)")
print("================================================")

drink_log <- tibble(
  drinkName  = c("Taro Milk Tea", "Brown Sugar Boba", "Matcha Latte", "Mango Slush"),
  price      = c(7.00, 6.50, 9.00, 8.00),
  sugarLevel = c(1.00, NA, 0.50, NA) # two levels were never recorded
)

print("Drink log with missing sugar levels:")
print(drink_log)

# Any arithmetic on a column containing NA produces NA for those positions
print("Sugar level + 0.25 for each drink:")
print(drink_log$sugarLevel + 0.25)
# [1] 1.25   NA 0.75   NA

# mean() returns NA if ANY value in the column is NA (default behaviour)
print("Average sugar level — default (fails because of NAs):")
print(mean(drink_log$sugarLevel))
# [1] NA

# Set na.rm = TRUE to ignore NAs and compute on available values only
print("Average sugar level — na.rm = TRUE (ignores missing values):")
print(mean(drink_log$sugarLevel, na.rm = TRUE))
# [1] 0.75  (average of 1.00 and 0.50 only)

# is.na() returns TRUE/FALSE for each element — TRUE means it IS missing
print("Which sugar levels are missing?")
print(is.na(drink_log$sugarLevel))
# [1] FALSE  TRUE FALSE  TRUE

# Combine sum() and is.na() to COUNT how many NAs exist
print("Total number of missing sugar levels:")
print(sum(is.na(drink_log$sugarLevel)))
# [1] 2
