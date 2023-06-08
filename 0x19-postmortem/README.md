# HBNB Outage Incident Report
June 08, 2023
<br>

By the HBNB DevOps Team

The following is the incident report for the HBNB application outage on June 06, 2023. We understand this issue has impacted our valued customers and team, and we apologise to everyone affected.

## Issue Summary

From 9:06 AM to 10:00 AM EAT, requests made by HBNB users seemed to be throwing a `408 Request timeout` error and affected the functionality of the HBNB application. The issue affected more than 50% of the traffic to the application's backend. The root cause of the outage was a poorly configured Nginx server that was deployed to reduce traffic overload on the primary Nginx server. 

## Timeline (all times East Africa Time)
- 9:06 AM: New Nginx Server is deployed and the load balancer is restarted with new configurations 
- 9:18 AM: Outage begins
- 9:18 AM: Datadog alerted teams
- 9:24 AM: Change rollback successful
- 9:32 AM: New Nginx server with proper configuration deployed
- 9:44 AM: Load balancer reconfigured and restarted
- 10:00 AM: 100% of traffic routed successfully

## Root Cause and resolution
At 9:06 AM EAT, a new Nginx server was spun up and the load balancer was updated with new configurations. The primary server was overloaded by the available traffic based on the monitoring data. Hence, the DevOps team decided to deploy a new Nginx server to help route and balance the traffic to prevent the primary server from being overloaded. However, the new Nginx server was not well configured and hence did not bind to port 80. Therefore, it could not serve the traffic making the primary Nginx server to continue being overloaded. 
At 9:18 AM, the primary Nginx server eventually experienced thread lock leading to some users experiencing zero application functionality as traffic was jammed. At 9:24 AM the DevOps team was able to reconfigure the load balancer and limit traffic to 50% to the primary server. AT 9:32 AM an Nginx server with proper configuration was deployed, and the load balancer was reconfigured and restarted at 9:44 AM. 100% of traffic was routed to both Nginx servers at 10:00 AM.

## Corrective and preventative measures
After conducting an internal review and analysis of the outage, the following are actions to be implemented to prevent a recurrent event and improve application reliability:
- Implement adequate tooling to test the configuration of Nginx servers before deploying them to the production environment.
- Deploy server resources in the test environment and scale them to the production environment to prevent such failure.
- Implement an auto-scaling mechanism where server resources that have been tested and are on standby are deployed with less friction to the production environment.
