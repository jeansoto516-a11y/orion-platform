# ---------- Rede ----------
resource "docker_network" "orion_net" {
  name = var.network_name
}

# ---------- Volume de persistencia do banco ----------
resource "docker_volume" "orion_pgdata" {
  name = "orion_pgdata_tf"
}

# ---------- Imagens ----------
resource "docker_image" "postgres" {
  name = "postgres:18"
}

resource "docker_image" "api" {
  name = "orion-backend-tf:latest"
  build {
    context = "${path.module}/../../backend/orion-backend"
  }
}

resource "docker_image" "frontend" {
  name = "orion-frontend-tf:latest"
  build {
    context = "${path.module}/../../frontend"
  }
}

# ---------- Container: banco de dados ----------
resource "docker_container" "db" {
  name  = "orion-db-tf"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=orion_db",
    "POSTGRES_USER=orion_user",
    "POSTGRES_PASSWORD=${var.database_password}"
  ]

  networks_advanced {
    name = docker_network.orion_net.name
  }

  ports {
    internal = 5432
    external = var.db_port
  }

  volumes {
    volume_name    = docker_volume.orion_pgdata.name
    container_path = "/var/lib/postgresql"
  }

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U orion_user -d orion_db"]
    interval = "5s"
    timeout  = "5s"
    retries  = 5
  }
}

# ---------- Container: API backend ----------
resource "docker_container" "api" {
  name  = "orion-api-tf"
  image = docker_image.api.image_id

  env = [
    "DATABASE_HOST=orion-db-tf",
    "DATABASE_PORT=5432",
    "DATABASE_NAME=orion_db",
    "DATABASE_USER=orion_user",
    "DATABASE_PASSWORD=${var.database_password}",
    "JWT_SECRET=${var.jwt_secret}"
  ]

  networks_advanced {
    name = docker_network.orion_net.name
  }

  ports {
    internal = 8080
    external = var.api_port
  }

  depends_on = [docker_container.db]
}

# ---------- Container: frontend ----------
resource "docker_container" "frontend" {
  name  = "orion-frontend-tf"
  image = docker_image.frontend.image_id

  networks_advanced {
    name = docker_network.orion_net.name
  }

  ports {
    internal = 80
    external = var.frontend_port
  }

  depends_on = [docker_container.api]
}