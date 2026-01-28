#!/usr/bin/env bash

start=16
iterations=10
mult=2
output_file="matrixElapsed.txt"

> "$output_file"

value=$start

for((i=1; i<=iterations; i++)) do
	./matrix_cpu "$value" >> "$output_file"
	value=$((value*mult))
done
