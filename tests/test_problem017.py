from project_euler import problem017


def test_problem017():
    assert problem017.main() == 21124


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
