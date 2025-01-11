# Parameters
rows <- 3  # Grid rows
cols <- 4  # Grid columns
discount <- 0.99  # Discount factor (gamma)
p <- 0.02  # Stochasticity level (inaccuracy level)
epsilon <- 1e-6  # Convergence threshold

# Define states (grid positions)
states <- expand.grid(row = 1:rows, col = 1:cols)  # All grid positions
actions <- c("Up", "Down", "Left", "Right")
terminal_states <- list(
  green = c(row = 1, col = 4),  # Green cell
  orange = c(row = 3, col = 4)  # Orange cell
)

# Initialize value function and policy
value_function <- array(0, dim = c(rows, cols))  # Value function for each state
policy <- array("", dim = c(rows, cols))  # Optimal policy for each state

# Reward function: explicitly handle the grey cell
reward_function <- function(state) {
  if (all(state == terminal_states$green)) return(100)  # Green cell
  if (all(state == terminal_states$orange)) return(-100)  # Orange cell
  if (all(state == c(row = 2, col = 2))) return(NA)  # Grey cell (unreachable)
  return(-1)  # Default step cost
}

# Transition probabilities function
transition_prob <- function(state, action) {
  row <- as.numeric(state["row"])
  col <- as.numeric(state["col"])
  intended <- switch(
    action,
    "Up" = c(row = max(row - 1, 1), col = col),
    "Down" = c(row = min(row + 1, rows), col = col),
    "Left" = c(row = row, col = max(col - 1, 1)),
    "Right" = c(row = row, col = min(col + 1, cols))
  )
  
  # Perpendicular directions
  perpendicular <- list(
    "Up" = list(
      c(row = row, col = max(col - 1, 1)),
      c(row = row, col = min(col + 1, cols))
    ),
    "Down" = list(
      c(row = row, col = max(col - 1, 1)),
      c(row = row, col = min(col + 1, cols))
    ),
    "Left" = list(
      c(row = max(row - 1, 1), col = col),
      c(row = min(row + 1, rows), col = col)
    ),
    "Right" = list(
      c(row = max(row - 1, 1), col = col),
      c(row = min(row + 1, rows), col = col)
    )
  )[[action]]
  
  # Build probabilities
  probs <- list(
    intended = c(intended, prob = 1 - 2 * p),
    perpendicular_1 = c(perpendicular[[1]], prob = p),
    perpendicular_2 = c(perpendicular[[2]], prob = p)
  )
  
  # Convert lists to numeric values
  probs <- lapply(probs, function(transition) {
    list(
      row = as.numeric(transition["row"]),
      col = as.numeric(transition["col"]),
      prob = as.numeric(transition["prob"])
    )
  })
  return(probs)
}

# Value iteration: skip grey cell during updates
delta <- Inf  # Maximum change in the value function
while (delta > epsilon) {
  new_value_function <- array(0, dim = c(rows, cols))  # Updated value function
  delta <- 0
  
  for (state in seq_len(nrow(states))) {
    current_state <- states[state, ]
    row <- as.numeric(current_state["row"])
    col <- as.numeric(current_state["col"])
    
    # Skip grey cell (2,2)
    if (row == 2 && col == 2) {
      new_value_function[row, col] <- NA
      policy[row, col] <- "N/A"
      next
    }
    
    # Terminal states always retain their reward
    if (all(current_state == terminal_states$green) || all(current_state == terminal_states$orange)) {
      new_value_function[row, col] <- reward_function(current_state)
      policy[row, col] <- "Terminal"
      next
    }
    
    # Evaluate each action
    action_values <- sapply(actions, function(action) {
      transitions <- transition_prob(current_state, action)
      immediate_reward <- reward_function(current_state)
      future_value <- sum(sapply(transitions, function(transition) {
        transition_row <- transition$row
        transition_col <- transition$col
        transition_prob <- transition$prob
        if (transition_row == 2 && transition_col == 2) return(0)  # Skip grey cell
        value_function[transition_row, transition_col] * transition_prob
      }))
      return(immediate_reward + discount * future_value)
    })
    
    # Update value and policy
    new_value_function[row, col] <- max(action_values)
    policy[row, col] <- actions[which.max(action_values)]
    delta <- max(delta, abs(new_value_function[row, col] - value_function[row, col]))
  }
  
  value_function <- new_value_function  # Update value function
}

# Print results
cat("Optimal Value Function:\n")
print(value_function)  # Final value function

cat("\nOptimal Policy:\n")
print(policy)  # Optimal policy
