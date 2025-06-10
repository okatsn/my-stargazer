// example-comprehensive-test.typ
// Comprehensive testing pattern for Typst packages

#import "@local/my-package:0.1.0": *

// Test 1: Basic functionality
#let basic-test() = {
  let result = my-function("input")
  assert(result != none, message: "Function should not return none")
  result
}

// Test 2: Edge cases
#let edge-case-test() = {
  // Test with empty input
  let empty-result = my-function("")
  // Test with special characters
  let special-result = my-function("special-chars: @#$%")
  // Return both for visual inspection
  (empty: empty-result, special: special-result)
}

// Test 3: Error handling (manual verification needed)
#let error-test() = {
  // These should produce expected errors or graceful handling
  // my-function(invalid-input)  // Uncomment to test
}

// Test 4: Visual output tests
= Package Test Results

== Basic Functionality
Result: #basic-test()

== Edge Cases  
#let edge-results = edge-case-test()
Empty input: #edge-results.empty
Special chars: #edge-results.special

== Visual Tests
Here's how the package output looks:
#my-formatting-function()[
  This is formatted content that should look correct.
]

// Test 5: Performance test (for complex packages)
#let performance-test() = {
  let start-time = datetime.today()
  let result = my-expensive-function(large-input)
  // Log timing if needed
  result
}

✓ All tests completed. Review output visually for correctness.
