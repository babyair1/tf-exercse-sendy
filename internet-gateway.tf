resource "aws_internet_gateway" "tv-igw" {
  vpc_id = aws_vpc.exercise-vpc.id


  tags = {
    Name = "tv-igw"
  }
}