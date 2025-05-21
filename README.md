# Wongnok Web Application

## Overview

This project is a web application for managing food receipts. It consists of a frontend application, a backend API, a reverse proxy for the backend, and a SQL Server database. The entire stack is designed to be run using Docker Compose for ease of development and deployment.

## Project Structure

The project is organized into the following main directories:

-   `backend/`: Contains the source code and Dockerfile for the backend application.
-   `frontend/`: Contains the source code and Dockerfile for the frontend application.
-   `central/`: Contains the main `compose.yml` file and configurations for shared services like the reverse proxy (`central/nginx/`).
-   `database/`: Contains SQL initialization scripts (`database/initialize.sql`).

## Prerequisites

Before you begin, ensure you have the following installed on your system:

-   Docker
-   Docker Compose

## Getting Started

Follow these steps to get the application up and running:

1.  **Clone the repository (if you haven't already):**
    ```bash
    git clone <your-repository-url>
    cd food-receipt-web
    ```

2.  **Navigate to the Docker Compose directory:**
    The main `compose.yml` file is located in the `central/` directory.
    ```bash
    cd central
    ```

3.  **Build and run the application:**
    Use Docker Compose to build the images and start the services.
    ```bash
    docker-compose up --build
    ```
    To run in detached mode (in the background):
    ```bash
    docker-compose up --build -d
    ```

4.  **Stopping the application:**
    To stop the services:
    ```bash
    docker-compose down
    ```
    If you want to remove the volumes as well (e.g., to reset the database):
    ```bash
    docker-compose down -v
    ```

## Services

The `compose.yml` defines the following services:

### `backend-app`

-   **Container Name:** `backend-app`
-   **Build Context:** `../backend`
-   **Description:** The main backend application/API for the food receipt system.
-   **Network:** `wongnok-network` (Static IP: `192.168.1.2`)

### `frontend-app`

-   **Container Name:** `frontend-app`
-   **Build Context:** `../frontend`
-   **Description:** The user-facing frontend application.
-   **Ports:** `80:80` (Accessible via `http://localhost` or `http://localhost:80`)
-   **Network:** `wongnok-network` (Static IP: `192.168.1.4`)

### `reverse-proxy-backend`

-   **Container Name:** `reverse-proxy-backend`
-   **Build Context:** `./nginx` (relative to `central/` directory)
-   **Description:** An Nginx reverse proxy that sits in front of the `backend-app`.
-   **Ports:** `8082:70` (Accessible via `http://localhost:8082`. Nginx inside the container listens on port `70`.)
-   **Depends On:** `backend-app`
-   **Environment Variables:**
    -   `REVERSE_PROXY_PORT=8082` (Note: Host port is defined by `ports` mapping)
    -   `TZ=Asia/Bangkok`
-   **Network:** `wongnok-network` (Static IP: `192.168.1.5`)

### `sqlserver`

-   **Container Name:** `sqlserver`
-   **Image:** `mcr.microsoft.com/mssql/server`
-   **Description:** Microsoft SQL Server database instance.
-   **Ports:** `1433:1433` (Accessible on the host at port `1433`)
-   **Environment Variables:**
    -   `MSSQL_SA_PASSWORD="yourStrong(!)Password"` (Consider using a `.env` file for sensitive data in production)
    -   `ACCEPT_EULA="Y"`
-   **Volumes:**
    -   `../database:/post-init-scripts` (This volume seems intended for `sql-init`. For data persistence, consider mapping a volume to `/var/opt/mssql`.)
-   **Network:** `wongnok-network` (Static IP: `192.168.1.6`)

### `sql-init`

-   **Image:** `mcr.microsoft.com/mssql-tools`
-   **Description:** A utility service to initialize the `sqlserver` database using scripts.
-   **Depends On:** `sqlserver`
-   **Volumes:** `../database:/post-init-scripts` (Mounts the `../database` directory, which should contain `initialize.sql`)
-   **Command:** Executes `/post-init-scripts/initialize.sql` against the `sqlserver` instance.
-   **Network:** `wongnok-network` (Static IP: `192.168.1.7`)

## Networking

All services are connected to a custom bridge network named `wongnok-network` (`192.168.1.0/24`). Each service is assigned a static IP address within this network, which can be useful for inter-service communication if needed, though Docker Compose service names are generally preferred.

## Environment Variables

Key environment variables are defined within the `compose.yml`:

-   **`sqlserver`**:
    -   `MSSQL_SA_PASSWORD`: The password for the SQL Server 'SA' user. **Important:** The default value `"yourStrong(!)Password"` is insecure and should be changed, especially for any non-local environments. Consider managing this with a `.env` file and `env_file` directive in `compose.yml` or Docker secrets.
    -   `ACCEPT_EULA`: Must be "Y" to use the MS SQL Server image.
-   **`reverse-proxy-backend`**:
    -   `REVERSE_PROXY_PORT`: Set to `8082`. The actual host port exposure is `8082:70`.
    -   `TZ`: Timezone for the reverse proxy container, set to `Asia/Bangkok`.

## Accessing the Application

-   **Frontend:** `http://localhost` (or `http://localhost:80`)
-   **Backend API (via Reverse Proxy):** `http://localhost:8082`
-   **SQL Server Database:** Can be accessed on `localhost:1433` using a SQL client (e.g., Azure Data Studio, DBeaver) with username `SA` and the password defined in `MSSQL_SA_PASSWORD`.

## Database Initialization

The `sql-init` service automatically runs when you start the services with `docker-compose up`. It waits for `sqlserver` to be ready and then executes the `../database/initialize.sql` script.

The script path is relative to the `compose.yml` file in the `central/` directory. Ensure your `initialize.sql` file is present in the `database/` directory at the project root.

Logs from this service will indicate success or failure:
```
sql-init_1  | Waiting for SQL Server to be fully ready...
sql-init_1  | Post-start script executed successfully.
```
or
```
sql-init_1  | Post-start script execution failed.
```

## Troubleshooting

-   **Port Conflicts:** If you encounter errors about ports already being in use (e.g., for port 80, 8082, or 1433), ensure no other applications on your host machine are using these ports. You can change the host-side port mappings in the `compose.yml` file if necessary (e.g., change `"80:80"` to `"8081:80"`).
-   **`sql-init` fails:** Check the logs of the `sql-init` container (`docker-compose logs sql-init`). Ensure `sqlserver` is running correctly and that the `initialize.sql` script is valid and accessible at `../database/initialize.sql`.
-   **Build failures:** Check the logs during the `docker-compose up --build` process for specific error messages related to Dockerfile instructions or missing dependencies in the `backend`, `frontend`, or `central/nginx` directories.

## License

This project is licensed under the MIT License.