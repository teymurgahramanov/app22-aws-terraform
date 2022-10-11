output "URL" {
  value = "http://${aws_lb.main.dns_name}"
}