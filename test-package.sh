#!/bin/bash
# test-package.sh - Local testing script

# 1. Create local package directory
PACKAGE_DIR="$HOME/.local/share/typst/packages/local/my-awesome-package/0.1.0"
mkdir -p "$PACKAGE_DIR"

# 2. Copy package files (excluding tests, examples, etc.)
cp -r lib.typ typst.toml README.md LICENSE "$PACKAGE_DIR/"

# 3. Test the package locally
echo "Testing package locally..."
typst compile tests/test-basic.typ tests/test-basic.pdf

# 4. Check if compilation succeeded
if [ $? -eq 0 ]; then
    echo "✓ Package tests passed!"
    echo "You can now import with: #import \"@local/my-awesome-package:0.1.0\": *"
else
    echo "✗ Package tests failed!"
    exit 1
fi

# 5. Run additional tests
for test_file in tests/*.typ; do
    if [ -f "$test_file" ]; then
        echo "Running $test_file..."
        typst compile "$test_file" "${test_file%.typ}.pdf"
    fi
done
