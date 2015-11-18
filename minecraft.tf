resource "aws_instance" "minecraft" {
    lifecycle {
#        prevent_destroy = true
    }
    ami = "${module.ami.ami_id}"
    instance_type = "m3.large"
    source_dest_check = false
    key_name = "${aws_key_pair.awsnycast.key_name}"
    subnet_id = "${aws_subnet.publica.id}"
    security_groups = ["${aws_security_group.allow_all.id}"]
    tags {
        Name = "minecraft"
    }
    user_data = "${file(\"${path.module}/minecraft.conf\")}"
    iam_instance_profile = "${aws_iam_instance_profile.test_profile.id}"
    provisioner "remote-exec" {
        inline = [
          "while sudo pkill -0 cloud-init; do sleep 2; done"
        ]
        connection {
          user = "ubuntu"
          key_file = "id_rsa"
        }
    }
}

output "minecraft_public_ip" {
    value = "${aws_instance.minecraft.public_ip}"
}

