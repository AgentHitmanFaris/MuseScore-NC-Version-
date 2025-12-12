/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-CLA-applies
 *
 * MuseScore
 * Music Composition & Notation
 *
 * Copyright (C) 2021 MuseScore Limited and others
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
#include "global/stringutils.h"
#include <gtest/gtest.h>

using namespace muse;

class Global_StringUtilsTests : public ::testing::Test {
public:
};

TEST_F(Global_StringUtilsTests, Join) {
  {
    std::vector<std::string> parts = {"a", "b", "c"};
    EXPECT_EQ(strings::join(parts, ","), "a,b,c");
  }
  {
    std::vector<std::string> parts = {"a"};
    EXPECT_EQ(strings::join(parts, ","), "a");
  }
  {
    std::vector<std::string> parts = {};
    EXPECT_EQ(strings::join(parts, ","), "");
  }
  {
    std::vector<std::string> parts = {"a", "b"};
    EXPECT_EQ(strings::join(parts, " -- "), "a -- b");
  }
}

TEST_F(Global_StringUtilsTests, EndsWith) {
  EXPECT_TRUE(strings::endsWith("filename.txt", ".txt"));
  EXPECT_TRUE(strings::endsWith("filename.txt", "txt"));
  EXPECT_TRUE(strings::endsWith("filename.txt", "filename.txt"));
  EXPECT_FALSE(strings::endsWith("filename.txt", ".tx"));
  EXPECT_FALSE(strings::endsWith("filename.txt", "filename.txtt"));
  EXPECT_FALSE(strings::endsWith("", "a"));
  EXPECT_FALSE(strings::endsWith("a", "abc"));
}

TEST_F(Global_StringUtilsTests, StartsWith) {
  EXPECT_TRUE(strings::startsWith("filename.txt", "file"));
  EXPECT_TRUE(strings::startsWith("filename.txt", "f"));
  EXPECT_TRUE(strings::startsWith("filename.txt", "filename.txt"));
  EXPECT_FALSE(strings::startsWith("filename.txt", "File"));
  EXPECT_FALSE(strings::startsWith("filename.txt", "filename.txtt"));
  EXPECT_FALSE(strings::startsWith("", "a"));
  EXPECT_FALSE(strings::startsWith("a", "abc"));
}

TEST_F(Global_StringUtilsTests, LessThanCaseInsensitive) {
  // std::string overload
  {
    std::string a = "abc";
    std::string b = "DEF";
    EXPECT_TRUE(strings::lessThanCaseInsensitive(a, b));
    EXPECT_FALSE(strings::lessThanCaseInsensitive(b, a));
  }
  {
    std::string a = "abc";
    std::string b = "ABC";
    // When equal case-insensitive, it compares case-sensitive (abc > ABC)
    // Wait, 'a' (97) > 'A' (65). So "abc" > "ABC".
    // The original implementation returns lhs < rhs if equal case-insensitive.
    // So "abc" < "ABC" is false.
    EXPECT_FALSE(strings::lessThanCaseInsensitive(a, b));
    EXPECT_TRUE(strings::lessThanCaseInsensitive(b, a));
  }
  {
    std::string a = "apple";
    std::string b = "Banana";
    EXPECT_TRUE(strings::lessThanCaseInsensitive(a, b));
  }
  {
    std::string a = "apple";
    std::string b = "applepie";
    EXPECT_TRUE(strings::lessThanCaseInsensitive(a, b));
  }
}
