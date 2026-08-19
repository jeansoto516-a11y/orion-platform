output "frontend_url" {
  description = "URL de acesso ao frontend"
  value       = "http://localhost:${var.frontend_port}"
}

output "api_url" {
  description = "URL de acesso a API"
  value       = "http://localhost:${var.api_port}"
}

output "health_check_url" {
  description = "URL do endpoint de health check"
  value       = "http://localhost:${var.api_port}/actuator/health"
}