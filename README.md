<!-- markdownlint-disable MD033 -->

# Wongnok Food Receipt Web Application

## Overview

This project is a full-stack web application designed for managing food receipts. It comprises a frontend application, a backend API, a reverse proxy for the backend, and a SQL Server database, all orchestrated using Docker Compose for streamlined development and deployment.

The primary goal is to provide a robust and easy-to-run environment for developing and testing the food receipt management system.

## Project Structure

The repository is organized into the following key directories:

-   `backend/`: Contains the source code and Dockerfile for the backend API application.
-   `frontend/`: Contains the source code and Dockerfile for the user-facing frontend application.
-   `central/`: Houses the main `compose.yml` file and configurations for shared infrastructure services, such as the Nginx reverse proxy (`central/nginx/`).

## Tech Stack (Example - Please Update)

*   **Frontend:** (e.g., React, Vue, Angular, HTML/CSS/JS)
*   **Backend:** (e.g., Node.js with Express, Python with Django/Flask, Java Spring Boot)
*   **Database:** Microsoft SQL Server
*   **Reverse Proxy:** Nginx
*   **Containerization:** Docker, Docker Compose

## Prerequisites

To build and run this project locally using Docker Compose, you need to have the following installed:

-   Docker Engine
-   Docker Compose (usually included with Docker Desktop)

## Getting Started

Follow these steps to set up and run the application stack on your local machine:

1.  **Clone the repository:**
    If you haven't already, clone the project repository:
    ```bash
    git clone https://github.com/MisxyCC/wongnok-recipes.git
    cd food-receipt-web
    ```

2.  **Navigate to the Docker Compose directory:**
    The main `compose.yml` file is located in the `central/` directory.
    ```bash
    cd central
    ```

4.  **Build and run the application stack:**
    Use Docker Compose to build the necessary Docker images and start all defined services. The `--build` flag ensures images are rebuilt if their source files or Dockerfiles have changed.
    ```bash
    docker-compose up --build
    ```
    To run the services in the background (detached mode):
    ```bash
    docker-compose up --build -d
    ```
    The first build might take some time depending on your internet connection and system resources.

5.  **Verify Services:**
    Once `docker-compose up` completes, you can check the status of your services:
    ```bash
    docker-compose ps
    ```

6.  **Stopping the application:**
    To stop all running services defined in the `compose.yml`:
    ```bash
    docker-compose down
    ```
    To stop services and remove the volumes (useful for resetting the database state, including data in named volumes if configured):
    ```bash
    docker-compose down -v
    ```

## Configuration

Key configurations are managed via environment variables, primarily defined within the `compose.yml` file or, preferably for sensitive data, sourced from a `.env` file in the `central/` directory.

-   **Database (`sqlserver`):**
    -   `MSSQL_SA_PASSWORD`: The password for the SQL Server 'SA' user. **CRITICAL:** The default `"yourStrong(!)Password"` in `compose.yml` is highly insecure. **Always override this** using a `.env` file (as suggested in "Getting Started").
    -   `ACCEPT_EULA`: Must be set to `"Y"` to accept the Microsoft SQL Server license terms.
-   **Reverse Proxy (`reverse-proxy-backend`):**
    -   The Nginx container listens on port `70` internally, which is mapped to host port `8082` (as defined by `ports: - "8082:70"` in `compose.yml`).
    -   `REVERSE_PROXY_PORT=8082`: This environment variable is set to `8082`. It might be used by the Nginx configuration for internal logic (e.g., generating redirect URLs) but does not define the Nginx listening port within the container.
    -   `TZ`: Sets the timezone for the container (e.g., `Asia/Bangkok`).

Other services (`backend-app`, `frontend-app`) may have their own environment variables defined in their respective Dockerfiles or within the `compose.yml`. Refer to their specific documentation or code for details.

## Services Overview

The `compose.yml` file defines the following services:

### `backend-app`

-   **Description:** The core backend application/API responsible for business logic and data interaction.
-   **Build Context:** `../backend`
-   **Network:** `wongnok-network` (Static IP: `192.168.1.2`)
-   **Access:** Typically accessed internally by the `reverse-proxy-backend` service using its service name (`http://backend-app:<PORT>`).

### `frontend-app`

-   **Description:** The user interface application that users interact with.
-   **Build Context:** `../frontend`
-   **Ports:** `80:80` (Maps container port 80 to host port 80)
-   **Network:** `wongnok-network` (Static IP: `192.168.1.4`)
-   **Access:** Accessible from your host machine's browser.

### `reverse-proxy-backend`

-   **Description:** An Nginx instance acting as a reverse proxy for the `backend-app`. It handles routing requests to the backend.
-   **Build Context:** `./nginx` (relative to `central/` directory)
-   **Ports:** `8082:70` (Maps container port 70 to host port 8082)
-   **Depends On:** `backend-app` (Ensures backend starts before the proxy)
-   **Network:** `wongnok-network` (Static IP: `192.168.1.5`)
-   **Access:** Accessible from your host machine.

### `sqlserver`

-   **Description:** A Microsoft SQL Server database instance used to store application data.
-   **Image:** `mcr.microsoft.com/mssql/server`
-   **Ports:** `1433:1433` (Maps container port 1433 to host port 1433)
-   **Network:** `wongnok-network` (Static IP: `192.168.1.6`)
-   **Access:** Accessible from your host machine using a SQL client, and from other services on the `wongnok-network` using `sqlserver:1433`.

## Networking

All services are connected to a custom Docker bridge network named `wongnok-network` with a subnet of `192.168.1.0/24`.

Each service is assigned a static IP address within this network. While static IPs are configured, it's **highly recommended** to use Docker's built-in DNS and refer to services by their service names (e.g., `backend-app`, `sqlserver`) for inter-service communication within the Docker network. This is more robust and flexible than relying on hardcoded IP addresses.

## Accessing the Application

Once the Docker Compose stack is running, you can access the application components from your host machine:

-   **Frontend Application:** Open your web browser and go to `http://localhost` (or `http://localhost:80`).
-   **Backend API (via Reverse Proxy):** Access the API endpoints through the reverse proxy at `http://localhost:8082`.
-   **SQL Server Database:** Connect using a SQL client (like Azure Data Studio, SQL Server Management Studio, DBeaver, etc.) to `localhost:1433` with username `SA` and the password you configured in your `.env` file (via `MSSQL_SA_PASSWORD`).

-   **Connecting to the Database:** Use a SQL client and the connection details provided in the "Accessing the Application" section.
-   **Hot-Reloading / Live Development:**
    To enable automatic reloading of your frontend or backend applications when you make code changes (without needing to rebuild the Docker image each time), map your local source code directories into the respective containers. Add `volumes` sections to your `frontend-app` and `backend-app` services in `compose.yml`. For example:
    ```yaml
    # In your compose.yml
    services:
      frontend-app:
        # ... other frontend-app config ...
        volumes:
          - ../frontend:/app # Maps the entire local frontend directory to /app in the container
          # Depending on your frontend setup, you might need to exclude node_modules:
          # - /app/node_modules # Anonymous volume to keep container's node_modules

      backend-app:
        # ... other backend-app config ...
        volumes:
          - ../backend:/app # Maps the entire local backend directory to /app in the container
          # Add other necessary volume mounts if needed (e.g., for dependencies not in source)
    ```
    *Note: The exact paths (`/app`, exclusion of `node_modules`) depend on your specific frontend/backend Dockerfile setup and how your development server watches for changes.*

-   **Debugging:** Configure your IDE (VS Code, IntelliJ, etc.) to attach to the running Docker containers for debugging the backend or frontend code. Docker extensions for IDEs can simplify this process.
-   **Viewing Logs:** To view logs for all services: `docker-compose logs -f`. To view logs for a specific service: `docker-compose logs -f <service-name>` (e.g., `docker-compose logs -f backend-app`).

## Troubleshooting

-   **Port Conflicts:** If `docker-compose up` fails due to ports already being in use (e.g., 80, 8082, 1433), identify the conflicting process on your host machine and stop it, or modify the host-side port mappings in the `compose.yml` (e.g., change `"80:80"` to `"8081:80"`).
-   **Container Logs:** Check the logs of individual containers for errors using `docker-compose logs <service-name>` (e.g., `docker-compose logs sqlserver`). Add the `-f` flag to follow logs in real-time.
-   **Database Initialization:** If the database doesn't seem initialized correctly:
    -   Check the logs of the `sqlserver` container.
-   **Build Failures:** Examine the output of `docker-compose up --build` carefully for errors during the build process of `backend-app`, `frontend-app`, or `reverse-proxy-backend`. These usually indicate issues with the Dockerfiles, source code, or dependencies.
-   **Permissions Issues (Volume Mounts):** If you're mounting local source code and encounter permission errors within the container, you might need to adjust file ownership or permissions, or configure your Docker containers to run with a user that matches your host user ID/GID.

## License

This project is licensed under the MIT License.