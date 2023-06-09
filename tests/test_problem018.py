from project_euler import problem018


def test_problem018():
    assert problem018.main() == 1074


def test_maximum_path_in_triangle():
    assert problem018.maximum_path_in_triangle(
        [
            [3],
            [7, 4],
            [2, 4, 6],
            [8, 5, 9, 3]
        ]
    ) == 23
