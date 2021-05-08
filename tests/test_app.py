import pytest

from package.app import app


# refer https://flask.palletsprojects.com/en/1.1.x/testing/
@pytest.fixture
def client():
    app.config["TESTING"] = True

    with app.test_client() as client:
        yield client


def test_index(client):
    result = client.get("/")
    assert b"<span style='color:red'>I am app 1</span>" == result.data
