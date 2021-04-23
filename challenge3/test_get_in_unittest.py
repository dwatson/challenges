import unittest

from GetIn import GetIn

obj1 = {"a":{"b":{"c":"d"}}}
obj2 = {"x": {"y": {"z": "a"}}}
obj3 = {"a":{"b":{"c":{"d":{"e":{"f":"g"}}}}}}

class TestGetIn(unittest.TestCase):
    def test_input_1(self):
        self.assertEqual(GetIn(obj1, "a/b/c"), "d", "Should be d")

    def test_input_2(self):
        self.assertEqual(GetIn(obj2, "x/y/z"), "a", "Should be a")

    def test_larger_input(self):
        self.assertEqual(GetIn(obj3, "a/b/c/d/e/f"), "g", "Should be g")

    # Tests for non existent keys, should return None
    def test_missing_key_start(self):
        self.assertEqual(GetIn(obj1, "x/b/c"), None, "Should be None")

    def test_missing_key_end(self):
        self.assertEqual(GetIn(obj1, "a/b/x"), None, "Should be None")

if __name__ == '__main__':
    unittest.main()