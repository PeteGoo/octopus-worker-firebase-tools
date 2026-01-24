#!/bin/bash
set -e

echo "=== Testing Octopus Worker Firebase Tools Image ==="
echo ""

# Track test results
TESTS_PASSED=0
TESTS_FAILED=0

run_test() {
    local test_name="$1"
    local test_cmd="$2"

    echo -n "Testing $test_name... "
    if eval "$test_cmd" > /dev/null 2>&1; then
        echo "PASSED"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo "FAILED"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# Test nvm is installed
run_test "nvm installation" "[ -s \"\$NVM_DIR/nvm.sh\" ]"

# Test Node.js is installed and accessible
run_test "node installation" "node --version"

# Test npm is installed and accessible
run_test "npm installation" "npm --version"

# Test firebase-tools is installed
run_test "firebase-tools installation" "firebase --version"

# Test firebase login:ci command exists (doesn't require auth)
run_test "firebase login:ci command" "firebase login:ci --help"

# Test firebase deploy command exists
run_test "firebase deploy command" "firebase deploy --help"

# Test firebase functions command exists
run_test "firebase functions command" "firebase functions:log --help"

# Test firebase hosting command exists
run_test "firebase hosting command" "firebase hosting:channel:list --help"

# Print versions
echo ""
echo "=== Installed Versions ==="
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "Firebase CLI: $(firebase --version)"

# Summary
echo ""
echo "=== Test Summary ==="
echo "Passed: $TESTS_PASSED"
echo "Failed: $TESTS_FAILED"

if [ $TESTS_FAILED -gt 0 ]; then
    echo ""
    echo "Some tests failed!"
    exit 1
fi

echo ""
echo "All tests passed!"
exit 0
