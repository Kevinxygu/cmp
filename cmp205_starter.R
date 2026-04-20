# COMM 205 — Molly Tea Vancouver: R Programming Session
# =========================================================
# Today we're building an order tracking system for Molly Tea,
# a bubble tea shop in Vancouver, Canada!
# =========================================================

library(tidyverse)

# Here is Molly Tea's current order queue (prices in CAD)
order_queue <- c(6.50, 7.00, 5.50, 8.00, 6.50, 7.50)
print(order_queue)


# =========================================================
# Checkpoint 1: A New Customer Arrives
# =========================================================
# A customer just walked in and ordered a drink for $8.50.
# Add their order to the queue.

print("================================================")
print("Checkpoint 1:")
print("================================================")

# YOUR CODE:


# =========================================================
# Checkpoint 2: Rewards Points
# =========================================================
# For every $1 CAD spent, customers earn 1.5 rewards points.
# Calculate the points earned for each order in the queue,
# then calculate the total points across all orders.

print("================================================")
print("Checkpoint 2:")
print("================================================")

points_per_dollar <- 1.5

# YOUR CODE:


# =========================================================
# Checkpoint 3: Currency Conversion (CAD to RMB)
# =========================================================
# The owner needs today's revenue reported in RMB.
# Convert every order price to RMB, then report the total.

print("================================================")
print("Checkpoint 3:")
print("================================================")

exchange_rate <- 5.0

# YOUR CODE:


# =========================================================
# Checkpoint 4: Building the Orders Tibble
# =========================================================
# Here is Molly Tea's full order log for today.

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
print("Checkpoint 4:")
print("================================================")
print(orders_df)

# (a) Print all drink names as a vector using $

# YOUR CODE:


# (b) Get the price of the 3rd order as a single value using [[]]

# YOUR CODE:


# (c) Which orders are priced above $7.50? (return TRUE/FALSE for each)

# YOUR CODE:


# (d) What is the most expensive order?

# YOUR CODE:


# =========================================================
# Checkpoint 5: Customer Rewards Level
# =========================================================
# Classify each customer into a rewards tier based on their
# total spending across all of their orders:
#   Level 2 (Gold)   — total spend >= $20
#   Level 1 (Silver) — total spend  < $20
#
# Create a new tibble called customer_totals with columns:
#   customerName, totalSpend, rewardLevel

print("================================================")
print("Checkpoint 5:")
print("================================================")

# YOUR CODE:


# =========================================================
# Checkpoint 6: Orders with Special Notes
# =========================================================
# Find all orders that have special barista instructions.
# Return the order numbers and the notes for those orders.

print("================================================")
print("Checkpoint 6:")
print("================================================")

# YOUR CODE:


# =========================================================
# Checkpoint 7: Updating the Tibble
# =========================================================
# (a) The Matcha Latte price has increased to $9.00.
#     Update the price in orders_df.

print("================================================")
print("Checkpoint 7:")
print("================================================")

# YOUR CODE:


# (b) Vancouver charges 5% GST. Add a priceWithTax column to orders_df.

# YOUR CODE:


# (c) Add an isPremium column — TRUE if price >= $8.00, FALSE otherwise.

# YOUR CODE:


# =========================================================
# Checkpoint 8: Missing Values (NA)
# =========================================================
# Some sugar levels were not recorded today.

drink_log <- tibble(
  drinkName  = c("Taro Milk Tea", "Brown Sugar Boba", "Matcha Latte", "Mango Slush"),
  price      = c(7.00, 6.50, 9.00, 8.00),
  sugarLevel = c(1.00, NA, 0.50, NA)
)

print("================================================")
print("Checkpoint 8:")
print("================================================")
print(drink_log)

# (a) Try adding 0.25 to every sugar level. What happens?

# YOUR CODE:


# (b) Calculate the average sugar level. What does R return by default?
#     Then calculate it again, ignoring the missing values.

# YOUR CODE:


# (c) Which sugar levels are missing? How many are there?

# YOUR CODE:
