# 🎯 Decision Analysis and Optimization Projects

![GitHub last commit](https://img.shields.io/github/last-commit/pmehta98/Decision-Optimization-Projects)
![GitHub repo size](https://img.shields.io/github/repo-size/pmehta98/Decision-Optimization-Projects)
![GitHub stars](https://img.shields.io/github/stars/pmehta98/Decision-Optimization-Projects?style=social)

## 📋 Table of Contents
- [Overview](#overview)
- [Projects](#projects)
- [Features](#features)
- [Setup](#setup)
- [Usage](#usage)
- [Repository Structure](#repository-structure)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## 📌 Overview

Welcome to the **Decision Analysis and Optimization Projects Repository**! This repository features a collection of **real-world decision-making problems** tackled using advanced techniques like **Markov Decision Processes (MDPs)**, **Decision Trees**, and **Expected Monetary Value (EMV)** calculations. Each project demonstrates structured problem-solving and optimization strategies across diverse scenarios from game theory to operational management.

---

## 📁 Projects

### 1️⃣ Who Wants to Be a Millionaire? & Brainy Business Case

- **Folder:** [`Who Wants to Be a Millionaire? & Brainy Business Case`](./Who%20Wants%20to%20be%20a%20Millionaire%20%26%20Brainy%20Business%20Case)
- **Objective:** Solve complex strategic decision-making problems using decision trees and EMV
- **Key Scenarios:**

  **i. Who Wants to Be a Millionaire?**
  - Optimize the contestant's strategy for maximizing winnings in the game show
  - **Analysis:** Evaluated different lifeline strategies and question difficulty levels
  - **Recommendation:** Use the "Phone a Friend" lifeline at the $1,000,000 question for maximum probability of success

  **ii. Brainy Business Case**
  - Help Cerebrosoft's CEO determine the best pricing strategy for their new product, Brainet, under competitive market scenarios
  - **Analysis:** Decision tree modeling under different competition scenarios (no competition, moderate, intense)
  - **Recommendation:** Launch the product at a **high price ($50/unit)** to maximize profitability across different competition levels

---

### 2️⃣ Brainy Business Case (Part 2) & Fruit Salad Case

- **Folder:** [`Brainy Business Case (2) & Fruit Salad`](./Brainy%20Business%20Case%20(2)%20%26%20Fruit%20Salad)
- **Objective:** Extend decision analysis with advanced scenarios involving market research and sampling strategies
- **Key Scenarios:**

  **i. Brainy Business Case (Part 2)**
  - Evaluate the value of investing $10,000 in additional market research to refine pricing strategy
  - **Analysis:** Value of Information (VOI) calculation
  - **Recommendation:** Skip the market research, as it does not improve the EMV significantly

  **ii. Fruit Salad Case**
  - Decide whether to sample fruit before accepting or rejecting a box to maximize profit
  - **Analysis:** Sequential decision-making with imperfect information
  - **Recommendation:** **Sample** the fruit to increase EMV and make informed decisions based on quality

---

### 3️⃣ Machine Maintenance & Robot Navigation

- **Folder:** [`Machine Maintenance & Robot Navigation`](./Machine%20Maintenance%20%26%20Robot%20Navigation)
- **Objective:** Optimize operational decisions using MDPs to maximize rewards and minimize costs
- **Key Scenarios:**

  **i. Machine Maintenance**
  - Develop a policy for maintaining, repairing, or replacing machines to maximize long-term profits
  - **Analysis:** Finite and infinite horizon MDPs with value iteration
  - **Recommendation:** **Maintain** the machine when running and **replace** it when broken
  - Policies optimized for both 10-week and 20-week time horizons

  **ii. Robot Navigation**
  - Determine the optimal path for a robot navigating a gridworld with stochastic movements to maximize rewards
  - **Analysis:** MDP with probabilistic state transitions
  - **Recommendation:** For higher uncertainty (p = 0.1), adopt safer routes to reduce penalty risks

---

## ✨ Features

- **Real-World Applications:** Game show strategy, pricing decisions, quality control, maintenance scheduling, robotics
- **Advanced Techniques:** MDPs, Decision Trees, EMV, Value of Information
- **Comprehensive Analysis:** Each project includes detailed problem formulation, analysis, and recommendations
- **Multiple Methodologies:** From simple decision trees to complex stochastic optimization
- **Practical Insights:** Actionable recommendations for strategic and operational decisions

---

## 🛠️ Setup

### Prerequisites

- R (version 4.0 or higher)
- RStudio (recommended)
- Required R packages:
  - MDPtoolbox (for Markov Decision Processes)
  - TreePlan (for Decision Trees, Excel add-in)
  - Base R packages for analysis

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/pmehta98/Decision-Optimization-Projects.git
   cd Decision-Optimization-Projects
   ```

2. **Install R packages:**
   ```r
   install.packages("MDPtoolbox")
   ```

3. **Navigate to a specific project folder:**
   ```bash
   cd "Machine Maintenance & Robot Navigation"
   ```

---

## 📖 Usage

1. Navigate to the desired project folder
2. Review the project-specific README for problem description and methodology
3. Open the R scripts or Excel files for detailed analysis
4. Run the code to reproduce results
5. Examine the decision trees, value functions, and policy recommendations

**Example:**
```bash
cd "Machine Maintenance & Robot Navigation"
# Open R script in RStudio
# Run the MDP analysis
# Review optimal policies
```

---

## 📂 Repository Structure

```
Decision-Optimization-Projects/
│
├── Who Wants to be a Millionaire & Brainy Business Case/
│   ├── README.md
│   ├── Analysis.xlsx
│   └── Report.pdf
│
├── Brainy Business Case (2) & Fruit Salad/
│   ├── README.md
│   ├── Analysis.xlsx
│   └── Report.pdf
│
├── Machine Maintenance & Robot Navigation/
│   ├── README.md
│   ├── MDP_Analysis.R
│   └── Report.pdf
│
└── README.md
```

---

## 🔧 Technologies Used

- **Programming:** R
- **Optimization Tools:** MDPtoolbox, TreePlan
- **Analysis Methods:**
  - Markov Decision Processes
  - Decision Tree Analysis
  - Expected Monetary Value (EMV)
  - Value Iteration
  - Value of Information (VOI)
- **Documentation:** Markdown, PDF reports

---

## 🤝 Contributing

Contributions are welcome! If you'd like to add new optimization projects or improve existing ones:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/NewOptimizationProject`)
3. Commit your changes (`git commit -m 'Add new optimization project'`)
4. Push to the branch (`git push origin feature/NewOptimizationProject`)
5. Open a Pull Request

---

## 📄 License

This repository is for educational and portfolio purposes. All projects are based on academic coursework and case studies.

---

## 📧 Contact

**Pranav Mehta**

- GitHub: [@pmehta98](https://github.com/pmehta98)
- Repository: [Decision-Optimization-Projects](https://github.com/pmehta98/Decision-Optimization-Projects)

---

⭐ If you find this repository helpful, please consider giving it a star!

---
