
# Question 1

# Load required library
library(MDPtoolbox)

# Define states and actions
states <- c("Running", "Broken")
actions <- c("Maintenance", "No Maintenance", "Repair", "Replace")
n_states <- length(states)
n_actions <- length(actions)

# Define transition probabilities (P)
P <- array(0, dim = c(n_states, n_states, n_actions), dimnames = list(states, states, actions))

# Transition probabilities for "Maintenance" when machine is Running
P["Running", "Running", "Maintenance"] <- 0.6
P["Running", "Broken", "Maintenance"] <- 0.4

# Transition probabilities for "No Maintenance" when machine is Running
P["Running", "Running", "No Maintenance"] <- 0.35
P["Running", "Broken", "No Maintenance"] <- 0.65

# Transition probabilities for "Repair" when machine is Broken
P["Broken", "Running", "Repair"] <- 0.6
P["Broken", "Broken", "Repair"] <- 0.4

# Transition probabilities for "Replace" when machine is Broken
P["Broken", "Running", "Replace"] <- 1.0

# Define rewards (R)
R <- array(-Inf, dim = c(n_states, n_actions), dimnames = list(states, actions))

# Rewards for actions when machine is Running
R["Running", "Maintenance"] <- 0.6 * 70 + 0.4 * (-30) # Reward for Maintenance
R["Running", "No Maintenance"] <- 0.35 * 100 - 0.65 * 0  # Reward for No Maintenance

# Invalid actions for Running
R["Running", "Repair"] <- -Inf
R["Running", "Replace"] <- -Inf

# Rewards for actions when machine is Broken
R["Broken", "Repair"] <- (0.6 * 40) + (0.4 * -60) # Reward for Repair
R["Broken", "Replace"] <- 100 - 110  # Reward for Replace

# Invalid actions for Broken
R["Broken", "Maintenance"] <- -Inf
R["Broken", "No Maintenance"] <- -Inf

# Solve the MDP for N = 10 weeks
N <- 10
result_10 <- mdp_finite_horizon(P, R, discount = 1, N = N)

# Map numeric policy indices to actions
map_policy_to_actions <- function(policy_matrix, actions) {
  apply(policy_matrix, 1:2, function(policy_index) {
    if (is.na(policy_index)) {
      return(NA)
    }
    return(actions[policy_index])
  })
}

policy_10 <- map_policy_to_actions(result_10$policy, actions)

# Print results for N = 10
cat("\nOptimal Policy for Each State at Each Week (N = 10):\n")
policy_table_10 <- as.data.frame(policy_10)
colnames(policy_table_10) <- paste("Week", 1:N)
rownames(policy_table_10) <- states
print(policy_table_10)

cat("\nValue Function for Each Time Step (N = 10):\n")
for (t in 1:N) {
  cat(paste("\nTime Step:", t, "\n"))
  value_table <- round(result_10$V[, t], 2)
  value_table <- data.frame(State = states, Value = value_table)
  print(value_table)
}

# Solve the MDP for N = 20 weeks
N <- 20
result_20 <- mdp_finite_horizon(P, R, discount = 1, N = N)

policy_20 <- map_policy_to_actions(result_20$policy, actions)

# Print results for N = 20
cat("\nOptimal Policy for Each State at Each Week (N = 20):\n")
policy_table_20 <- as.data.frame(policy_20)
colnames(policy_table_20) <- paste("Week", 1:N)
rownames(policy_table_20) <- states
print(policy_table_20)

cat("\nValue Function for Each Time Step (N = 20):\n")
for (t in 1:N) {
  cat(paste("\nTime Step:", t, "\n"))
  value_table <- round(result_20$V[, t], 2)
  value_table <- data.frame(State = states, Value = value_table)
  print(value_table)
}