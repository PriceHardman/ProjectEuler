from project_euler.utils import big_arithmetic

def test_add():
    assert big_arithmetic.add([0],[1]) == [1]
    assert big_arithmetic.add([1,0],[2,9]) == [3,9]
    assert big_arithmetic.add([4,9,8,2],[6,7]) == [5,0,4,9]