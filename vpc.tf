resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_eip" "main" {
  count      = length(var.public_subnet)
  vpc        = true
  depends_on = [aws_internet_gateway.main]
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_nat_gateway" "main" {
  count         = length(var.public_subnet)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.main.*.id, count.index)
}