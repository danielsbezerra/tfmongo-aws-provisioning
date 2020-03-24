output "vpc_id" {
  value = "${aws_vpc.mongodb-vpc.id}"
}

output "bastion_public_ip" {
  value = "${aws_instance.mongodb-bastion.public_ip}"
}