output "random_text" {
  sensitive = true
  value     = random_password.random_text.result
}
