#!/usr/bin/ruby
require 'json'

output = {
  "variable" => {
    "deploy_ssh_pubkey" => {
      "description" => "The Deployment ssh pub key",
      "default" => IO.read(File.dirname(__FILE__) + '/id_rsa.pub').chomp
    },
    "bucket_name" => {
        "description" => "The bucket name in s3",
        "default" => "terracraft",
    },
  }
}

puts JSON.pretty_generate(output)

