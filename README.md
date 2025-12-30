# Minecraft Server, Managed by AWS EC2

This is simply a Terraform-enabled version of an
[AWS for Games Blog post](https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/)
that details how to do this same setup manually, leaning in to the free tier
when possible. 

See [Cost Breakdown](#cost-breakdown) for details on how
much this might cost you using the default AWS price card.
The goal is to get pricing underneath the $7.99 USD per month rate
for a Java Realms account.


## How to Configure

So that you can tweak and modify this layout for your own use, you may want 
to create a new private GitHub (or just plain ole Git) repository and configure 
from there. Or clone this repo and use it directly for a vanilla installation.

Either way, you can tweak the configs to meet your needs. 
Within the `resources` directory there is one base file:
- `ec2.yml` - used to define the virtual server that the world will run within


## Cost Breakdown

A publicly accessible, Fargate-powered ECS service with a single task,
1 vCPU, and 3gb of RAM will cost you about $3.22 a day at current rates.
Of that, $1.29 is for the actual container resource costs,
$0.54 is for the [load balancer](https://aws.amazon.com/elasticloadbalancing/pricing/),
and $1.08 is for the [NAT gateway](https://aws.amazon.com/vpc/pricing/) in the VPC.

This means your bare minimum cost per day, even if your container is
powered down, is $1.62 a day, or $49.31 a month. If you use your Minecraft
server 12.5% of the month, that's still $54.98. Running full bore would
run you about $94.66 a month.

This doesn't even deal with S3, data transfer, Elastic IP,
or container storage costs. Bottom line - you aren't going to get better than
$8 per month on hosting unless you operate **many** worlds in a single
cluster, sharing a load balancer and a NAT gateway and reducing runtime to
around 2gb of memory.

Given all that, I decided to archive this project and chalk it up to a
learning experience. Still - this was a nifty project, if for no other reason
than it spells out how to manage an ECS cluster hosting an externally-facing
container using a Lambda-based API for management with Cognito for auth.
So that's fun.
