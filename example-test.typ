// Test file: tests/test-basic.typ
#import "../lib.typ": *

// Test your package functions
#let test-result = your-function("test-input")
#assert(test-result == "expected-output", message: "Basic function test failed")

// Visual tests - create documents that show expected output
= Test Results

Your package function result: #your-function("example")

Expected: This should produce the expected output.

// You can also test error conditions
#let error-test = {
  // Test that invalid input produces expected error
  // (This requires manual verification currently)
}

// Document that this test passed
✓ Basic functionality test passed
