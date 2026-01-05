# Minecraft Server, Managed by AWS EC2

This is simply a Terraform-enabled version of an
[AWS for Games Blog post](https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/)
that details how to do this same setup manually, leaning in to the free tier
when possible. 

See [Cost Breakdown](#cost-breakdown) for details on how
much this might cost you using the default AWS price card.
The goal is to get pricing underneath the $7.99 USD per month rate
for a Java Realms account.


## How to Install

1. Add minecraft user with `adduser minecraft`


## How to Configure

So that you can tweak and modify this layout for your own use, you may want 
to create a new private GitHub (or just plain ole Git) repository and configure 
from there. Or clone this repo and use it directly for a vanilla installation.

Either way, you can tweak the configs to meet your needs. 
Within the `resources` directory there is one base file:
- `ec2.yml` - used to define the virtual server that the world will run within


## Cost Breakdown

A dynamically allocated public IPv4 address will cost around $0.12 a day.

If you stay within the free EC2 tier your compute cost can remain at $0, 
but EBS GP3 storage will add $0.03 a day depending on the size you provision.

I haven't seen measurable data transfer costs yet with low usage,
but let's estimate that will add another $0.02 a day.

That would bring costs to about $0.17 a day, or around $5.18 a month.
