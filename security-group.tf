####################################
#####----SG for EC2 instance----####
####################################

resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.my-vpc.id
  tags = {
    name = "my-sg"
  }
}
#Inbound rules
resource "aws_vpc_security_group_ingress_rule" "inbound_rule_ipv4" {
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = aws_vpc.my-vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
#Outbound rules
resource "aws_vpc_security_group_egress_rule" "outbound_rule_ipv4" {
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


####################################
#########----SG for RDS----#########
####################################

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL only from EC2"
  vpc_id      = aws_vpc.my-vpc.id

  tags = {
    Name = "rds-sg"
  }
}
#Inbound rules for RDS
resource "aws_vpc_security_group_ingress_rule" "rds_inbound_rules" {
  security_group_id            = aws_security_group.rds_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
  referenced_security_group_id = aws_security_group.my-sg.id
}
#Outbound rules for RDS
resource "aws_vpc_security_group_egress_rule" "rds_outbound_rules" {
  security_group_id = aws_security_group.rds_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
