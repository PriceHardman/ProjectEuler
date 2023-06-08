import problem018
from project_euler import *

def test_to_words():
    assert problem017.to_words(1) == ["one"]
    assert problem017.to_words(10) == ["ten"]
    assert problem017.to_words(11) == ["eleven"]
    assert problem017.to_words(20) == ["twenty"]
    assert problem017.to_words(51) == ["fifty", "one"]
    assert problem017.to_words(100) == ["one", "hundred"]
    assert problem017.to_words(119) == ["one", "hundred", "and", "nineteen"]
    assert problem017.to_words(875) == ["eight", "hundred", "and", "seventy", "five"]
    assert problem017.to_words(1000) == ["one", "thousand"]


def test_maximum_path_in_triangle():
    assert problem018.maximum_path_in_triangle(
        [
            [3],
            [7, 4],
            [2, 4, 6],
            [8, 5, 9, 3]
        ]
    ) == 23
