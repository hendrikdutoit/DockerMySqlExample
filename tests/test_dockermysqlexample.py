# test_dockermysqlexample.py
import time

import pytest
import requests


def wait_for_service(url: str, timeout: int = 30) -> bool:
    """
    Helper function to wait for a service to become available
    for up to `timeout` seconds.
    Returns True if the service is available, otherwise False.
    """
    start_time = time.time()
    while True:
        try:
            response = requests.get(url)
            if response.status_code == 200:
                return True
        except requests.exceptions.ConnectionError:
            pass

        if time.time() - start_time > timeout:
            break

        time.sleep(1)
    return False


@pytest.mark.integration
def test_root_endpoint():
    """
    Test that the FastAPI service is up and returns a list
    of databases from the MySQL container.
    """
    # The FastAPI container is mapped to localhost:8001 in docker-compose.yaml
    url = "http://localhost:8001/"

    # Wait for the service to be up and responding
    service_up = wait_for_service(url, timeout=30)
    assert service_up, "FastAPI service did not become available within 30 seconds."

    # Perform the actual request
    response = requests.get(url)
    assert response.status_code == 200, f"Expected 200, got {response.status_code}"

    data = response.json()

    # Check that the response is either a list of databases or an error key
    # The code in dockermysqlexample.py returns {"databases": [...]} on success
    if "error" in data:
        pytest.fail(f"FastAPI returned an error: {data['error']}")
    else:
        assert "databases" in data, "Response JSON does not contain 'databases' key."
        # Optionally, verify that the expected database is present in the results
        db_list = [db_info[0] for db_info in data["databases"]]
        assert "DockerMySqlExample" in db_list, "Expected 'DockerMySqlExample' not found in the database list."
