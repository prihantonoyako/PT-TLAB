#!/bin/sh

# Program ini menggunakan menggunakan Fermat primality
# test (probabilistic algorithm). Sehingga
# dapat menghasilkan false positive untuk bilangan
# Carmichael.
# @author Yako Prihantono

# perhitungan modular dan eksponen
# a^n-1 := 1 (mod p)
power_mod() {
    local base=$1
    local exponent=$2
    local modulus=$3
    local result=1

    while (( exponent > 0 )); do
        if (( exponent % 2 == 1 )); then
            result=$(( (result * base) % modulus ))
        fi
        base=$(( (base * base) % modulus ))
        exponent=$(( exponent / 2 ))
    done

    echo $result
}

# Fermat primality test
fermat_primality_test() {
    local n=$1
    local iterations=$2

    # Check teorema dasar aritmatika
    if (( n <= 1 )); then
        return 1
    fi

    # Check menggunakan iterasi dengan base acak
    for ((i = 0; i < iterations; i++)); do
        a=$(( (RANDOM % (n - 2)) + 2 ))
        x=$(power_mod $a $((n - 1)) $n)
        if (( x != 1 )); then
            return 1
        fi
    done

    return 0
}
number=$1
iterations=10
if fermat_primality_test $number $iterations; then
	echo "bilangan ini adalah bilangan prima"
else
	echo "bilangan ini bukan bilangan prima"
fi
