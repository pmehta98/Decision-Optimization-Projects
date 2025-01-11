# Load required libraries
library(MDPtoolbox)
library(ggplot2)
library(gridExtra)

# Define transition matrices for each action (Up, Right, Left, Down)
create_transition_matrix <- function(p, rows = 3, cols = 4) {
  total_states <- rows * cols
  transition_matrices <- list(
    Up = matrix(0, nrow = total_states, ncol = total_states),
    Down = matrix(0, nrow = total_states, ncol = total_states),
    Left = matrix(0, nrow = total_states, ncol = total_states),
    Right = matrix(0, nrow = total_states, ncol = total_states)
  )
  
  # Helper function to get state index of cells from their own row, col number
  get_state_index <- function(row, col) (row - 1) * cols + col  
  
  # Wall location
  wall_state <- get_state_index(2, 2)       # Grey cell (2,2) has index 6
  
  # Terminal states
  green_terminal <- get_state_index(1, 4)   # Green terminal state (1,4) has index 4
  orange_terminal <- get_state_index(3, 4)  # Orange terminal state (3,4) has index 12
  
  # Directions and their perpendicular actions (Main direction, perpendicular direction1, perpendicular direction2)
  actions <- list(
    Up = list(main = c(-1, 0), perp1 = c(0, -1), perp2 = c(0, 1)),
    Down = list(main = c(1, 0), perp1 = c(0, -1), perp2 = c(0, 1)),  
    Left = list(main = c(0, -1), perp1 = c(-1, 0), perp2 = c(1, 0)),
    Right = list(main = c(0, 1), perp1 = c(-1, 0), perp2 = c(1, 0))
  )
  
  # Populate transition matrices
  for (action_name in names(actions)) {
    action <- actions[[action_name]]
    
    for (from_row in 1:rows) {
      for (from_col in 1:cols) {
        from_state <- get_state_index(from_row, from_col)
        
        # Skip wall state
        if (from_state == wall_state) next
        
        # Skip terminal states
        if (from_state %in% c(green_terminal, orange_terminal)) {
          transition_matrices[[action_name]][from_state, from_state] <- 0 # No transitions
          next
        }
        
        # Calculate main, perpendicular destination states
        main_dest_row <- from_row + action$main[1]
        main_dest_col <- from_col + action$main[2]
        perp1_dest_row <- from_row + action$perp1[1]
        perp1_dest_col <- from_col + action$perp1[2]
        perp2_dest_row <- from_row + action$perp2[1]
        perp2_dest_col <- from_col + action$perp2[2]
        
        # Main destination
        if (main_dest_row > 0 && main_dest_row <= rows &&     
            main_dest_col > 0 && main_dest_col <= cols &&     
            get_state_index(main_dest_row, main_dest_col) != wall_state) {
          main_dest_state <- get_state_index(main_dest_row, main_dest_col)
          transition_matrices[[action_name]][from_state, main_dest_state] <- 1 - 2 * p
          # Perpendicular destinations
          if (perp1_dest_row > 0 && perp1_dest_row <= rows && 
              perp1_dest_col > 0 && perp1_dest_col <= cols &&
              get_state_index(perp1_dest_row, perp1_dest_col) != wall_state) {
            perp1_dest_state <- get_state_index(perp1_dest_row, perp1_dest_col)
            transition_matrices[[action_name]][from_state, perp1_dest_state] <- p
          } else {
            transition_matrices[[action_name]][from_state, from_state] <- 
              transition_matrices[[action_name]][from_state, from_state] + p
          }
          
          if (perp2_dest_row > 0 && perp2_dest_row <= rows && 
              perp2_dest_col > 0 && perp2_dest_col <= cols &&
              get_state_index(perp2_dest_row, perp2_dest_col) != wall_state) {
            perp2_dest_state <- get_state_index(perp2_dest_row, perp2_dest_col)
            transition_matrices[[action_name]][from_state, perp2_dest_state] <- p
          } else {
            transition_matrices[[action_name]][from_state, from_state] <- 
              transition_matrices[[action_name]][from_state, from_state] + p
          }
        } else {
          transition_matrices[[action_name]][from_state, from_state] <- 1 - 2 * p
        }
      }
    }
  }
  return(transition_matrices)
}

# Create reward matrix
create_reward_matrix <- function(rows = 3, cols = 4) {
  total_states <- rows * cols
  
  # Create a matrix of rewards for each state and action
  R <- matrix(-1, nrow = total_states, ncol = 4)
  
  # Green terminal state reward (for all actions)
  green_terminal <- (1 - 1) * cols + 4  # (1,4) state
  R[green_terminal, ] <- 100
  
  # Orange terminal state reward (for all actions)
  orange_terminal <- (3 - 1) * cols + 4  # (3,4) state
  R[orange_terminal, ] <- -100
  
  # Grey wall state penalty (for all actions)
  wall_state <- (2 - 1) * cols + 2  # (2,2) state
  R[wall_state, ] <- -999999
  
  return(R)
}

# Combine transition matrices into a single 3D array
create_combined_transition_matrix <- function(transition_matrices) {
  num_states <- nrow(transition_matrices$Up)
  num_actions <- length(transition_matrices)
  
  # Create 3D array
  P <- array(0, dim = c(num_states, num_states, num_actions))
  
  # Fill 3D array with transition probabilities
  P[,,1] <- transition_matrices$Up
  P[,,2] <- transition_matrices$Down
  P[,,3] <- transition_matrices$Left
  P[,,4] <- transition_matrices$Right
  
  return(P)
}

# Set inaccuracy level
p <- 0.1

# Create transition matrices
transition_matrices <- create_transition_matrix(p)

# Combine transition matrices into 3D array
P <- create_combined_transition_matrix(transition_matrices)

# Create reward matrix
R <- create_reward_matrix()

# Solve the finite-horizon MDP
result <- mdp_value_iteration(P, R, discount = 0.99)

# Round values for better readability
result$V <- round(result$V, 2)

# Convert policy numbers to action names
action_names <- c("Up", "Down", "Left", "Right")
policy_names <- action_names[result$policy]
policy_names[6] <- "Wall"
policy_names[4] <- "Terminal"
policy_names[12] <- "Terminal"

# Print the value-to-go and policy as a table
cat("\nValue-to-Go and Optimal Policy Table:\n")
state_labels <- c("(1,1)", "(1,2)", "(1,3)", "(1,4)", 
                  "(2,1)", "(2,2)", "(2,3)", "(2,4)", 
                  "(3,1)", "(3,2)", "(3,3)", "(3,4)")
results_table <- data.frame(
  State = state_labels,
  `Value-to-Go` = result$V,
  `Optimal Policy` = policy_names
)
print(results_table)

# Visualization functions with reduced font size
visualize_policy <- function(policy, p, title) {
  grid_df <- data.frame(
    x = rep(1:4, 3),
    y = rep(3:1, each = 4),
    policy = policy,
    color = c(
      "White", "White", "White", "Green",
      "White", "Wall", "White", "White",
      "White", "White", "White", "Red"
    )
  )
  
  color_map <- c(
    "White" = "white", 
    "Green" = "green", 
    "Red" = "orange", 
    "Wall" = "gray"
  )
  
  plot1 <- ggplot(grid_df, aes(x = x, y = y)) +
    geom_tile(aes(fill = color), color = "black", linewidth = 0.5) +
    scale_fill_manual(values = color_map) +
    theme_minimal() +
    geom_text(aes(label = policy), size = 5) +
    ggtitle(title) +
    theme(
      panel.grid = element_blank(),
      axis.text = element_blank(),
      axis.title = element_blank(),
      legend.position = "none"
    ) +
    coord_fixed()
  
  return(plot1)
}

visualize_value <- function(values, p) {
  grid_df <- data.frame(
    x = rep(1:4, 3),
    y = rep(3:1, each = 4),
    value = round(values, 2),
    color = c(
      "White", "White", "White", "Green",
      "White", "Wall", "White", "White",
      "White", "White", "White", "Red"
    )
  )
  
  color_map <- c(
    "White" = "white", 
    "Green" = "green", 
    "Red" = "orange", 
    "Wall" = "gray"
  )
  
  plot2 <- ggplot(grid_df, aes(x = x, y = y)) +
    geom_tile(aes(fill = color), color = "black", linewidth = 0.5) +
    scale_fill_manual(values = color_map) +
    geom_text(aes(label = round(value, 2)), size = 5) +
    ggtitle(paste("Value Function for p =", p)) +
    theme_minimal() +
    theme(
      panel.grid = element_blank(),
      axis.text = element_blank(),
      axis.title = element_blank(),
      legend.position = "none"
    ) +
    coord_fixed()
  
  return(plot2)
}

# Create visualizations
p1 <- visualize_policy(policy_names, p, "Optimal Policy for p = 0.1")
p2 <- visualize_value(result$V, p)

# Display visualizations
grid.arrange(p1, p2, ncol = 1, nrow = 2, heights = c(4, 4))
