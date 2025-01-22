import pythontemplateit


class TestMyClass:
    def test_init(self, my_fixture):
        status = my_fixture
        myclass = pythontemplateit.MyClass(status)

        assert myclass.status
        pass
