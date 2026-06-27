#!/bin/bash

# Function to validate if the input is a positive number (integers or decimals)
validate_input() {
    local input_value=$1
    local field_name=$2

    # Check if input is empty
    if [ -z "$input_value" ]; then
        echo "Error: $field_name cannot be empty." >&2
        exit 1
    fi

    # Match positive integers or decimals (e.g., 100, 5.5, 0.25)
    if [[ ! "$input_value" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Error: $field_name must be a positive number." >&2
        exit 1
    fi

    # Ensure the number is strictly greater than zero
    if (( $(echo "$input_value <= 0" | bc -l) )); then
        echo "Error: $field_name must be greater than zero." >&2
        exit 1
    fi
}

# Main Execution Flow
echo "=== Simple Interest Calculator ==="

# 1. Get and validate Principal
read -p "Enter Principal Amount: " principal
validate_input "$principal" "Principal"

# 2. Get and validate Rate of Interest
read -p "Enter Annual Interest Rate (%): " rate
validate_input "$rate" "Interest Rate"

# 3. Get and validate Time Period
read -p "Enter Time Period (in years): " time
validate_input "$time" "Time Period"

# Calculate Simple Interest using 'bc' for floating-point math
# Formula: SI = (P * R * T) / 100
simple_interest=$(echo "scale=2; ($principal * $rate * $time) / 100" | bc -l)

# Calculate Total Amount
total_amount=$(echo "scale=2; $principal + $simple_interest" | bc -l)

# Display Results
echo "--------------------------------"
echo "Principal:        $principal"
echo "Interest Rate:    $rate%"
echo "Time Period:      $time year(s)"
echo "--------------------------------"
echo "Simple Interest:  $simple_interest"
echo "Total Amount:     $total_amount"
echo "--------------------------------"
