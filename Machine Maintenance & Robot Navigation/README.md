# 🤖 Machine Maintenance and Robot Navigation Analysis

This repository contains solutions to two decision-making problems using **Markov Decision Processes (MDPs)**: 
1. **Machine Maintenance** – Optimizing maintenance and repair strategies to maximize profit over a finite time horizon.
2. **Robot Navigation** – Finding the optimal policy for navigating a gridworld with rewards and penalties under uncertainty.

---

## 🗂️ Project Overview

### **1. Machine Maintenance Problem**
- **Objective**: Determine the optimal policy for maintaining, repairing, or replacing a machine to maximize profit over `N` weeks.
- **Problem Description**:
  - **States**: Machine is either **Running** or **Broken**.
  - **Actions**:
    1. **Running State**: Perform maintenance or do nothing.
    2. **Broken State**: Repair or replace.
  - **Rewards**:
    - Running with maintenance: $70.
    - Running without maintenance: $100.
    - Repair: $40 net profit.
    - Replace: -$10 net cost.
  - **Transition Probabilities**:
    - Preventive maintenance reduces failure probability.
    - Replacing guarantees the machine runs in the next period.
- **Results**:
  - For `N = 10` and `N = 20`, the optimal policy is:
    - **Maintain** when running.
    - **Replace** when broken.
    - Switch to **Do Nothing** or **Repair** in the final weeks to minimize costs.

---

### **2. Robot Navigation Problem**
- **Objective**: Navigate a gridworld to reach a green cell (+100 reward) while avoiding an orange cell (-100 penalty) under uncertain movements.
- **Problem Description**:
  - **Gridworld Layout**: 3x4 grid with one wall, a green terminal cell (+100), and an orange penalty cell (-100).
  - **States**: Each grid cell.
  - **Actions**: Move **Up**, **Down**, **Left**, or **Right**.
  - **Rewards**:
    - -1 for each valid move.
    - +100 for reaching the green cell.
    - -100 for reaching the orange cell.
    - -9999 for attempting invalid moves.
  - **Transition Probabilities**:
    - Movement is uncertain with accuracy based on `p`:
      - Move as intended with probability `1 - 2p`.
      - Deviate to perpendicular directions with probability `p` each.
- **Results**:
  - For `p = 0.02`: Optimal policy is direct paths to the green cell with high value-to-go.
  - For `p = 0.1`: The policy shifts to safer routes to avoid penalties, resulting in lower value-to-go due to increased risk.

---

## 📂 Repository Contents

| File Name                     | Description                                                  |
|-------------------------------|--------------------------------------------------------------|
| **`Q1_Final_Code.R`**         | R script for solving the Machine Maintenance problem.        |
| **`Q2_Final_Code.R`**         | R script for solving the Robot Navigation problem.           |
| **`Final_Report_3.pdf`**      | Comprehensive report detailing problem formulation, results, and analysis. |
| **`Project_Instructions_3.pdf`** | Detailed problem descriptions and requirements.            |

---

## 🔧 Tools and Techniques
- **Markov Decision Processes (MDPs)**:
  - Formulated as finite-horizon (Machine Maintenance) and infinite-horizon (Robot Navigation) MDPs.
- **R Programming**:
  - Used the `MDPtoolbox` package for solving MDPs.
- **Value Iteration**:
  - Implemented to calculate optimal policies and value-to-go functions.
- **Scenario Analysis**:
  - Evaluated results under varying time horizons (`N = 10`, `N = 20`) and uncertainty levels (`p = 0.02`, `p = 0.1`).

---
