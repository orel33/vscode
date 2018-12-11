// Simple demo for GTest Adapter plugin
// https://marketplace.visualstudio.com/items?itemName=DavidSchuldenfrei.gtest-adapter

#include <gtest/gtest.h>

int Factorial(int n) // Returns the factorial of n
{
  if (n < 2)
    return 1;
  else
    return n * Factorial(n - 1);
}

// Tests factorial of 0.
TEST(FactorialTest, HandlesZeroInput)
{
  EXPECT_EQ(Factorial(0), 1);
}

// Tests factorial of positive numbers.
TEST(FactorialTest, HandlesPositiveInput)
{
  EXPECT_EQ(Factorial(1), 1);
  EXPECT_EQ(Factorial(2), 2);
  EXPECT_EQ(Factorial(3), 6);
  EXPECT_EQ(Factorial(8), 40320);
}

/**
 * Programme principal
 */
int main(int argc, char **argv)
{
  /* run google tests */
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}